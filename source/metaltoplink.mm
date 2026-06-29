#ifdef TOUCHPY_MACOS

#include "metaltoplink.h"
#include "logging.h"

#import <Metal/Metal.h>
#include <TouchEngine/TEMetal.h>
#include <TouchEngine/TouchObject.h>

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

static inline TEObject* asTE(TEMetalTexture* p)   { return reinterpret_cast<TEObject*>(p); }
static inline TEObject* asTE(TEMetalSemaphore* p)  { return reinterpret_cast<TEObject*>(p); }

static void releaseTE(TEMetalTexture*& p)
{
    if (p) { auto* o = asTE(p); TERelease(&o); p = nullptr; }
}
static void releaseTE(TEMetalSemaphore*& p)
{
    if (p) { auto* o = asTE(p); TERelease(&o); p = nullptr; }
}

// ---------------------------------------------------------------------------
// associateDefaultMetalContext
// ---------------------------------------------------------------------------

void associateDefaultMetalContext(TEInstance* instance)
{
    id<MTLDevice> device = MTLCreateSystemDefaultDevice();
    if (!device)
    {
        spdlog::error("associateDefaultMetalContext: MTLCreateSystemDefaultDevice returned nil");
        return;
    }
    // TEMetalContextCreate returns a retained object — use take() to own it.
    TouchObject<TEMetalContext> context;
    TEResult result = TEMetalContextCreate(device, context.take());
    if (result != TEResultSuccess)
    {
        spdlog::error("TEMetalContextCreate failed: {}", TEResultGetDescription(result));
        return;
    }
    result = TEInstanceAssociateGraphicsContext(instance, context);
    if (result != TEResultSuccess)
        spdlog::error("TEInstanceAssociateGraphicsContext failed: {}", TEResultGetDescription(result));
    // context goes out of scope here; TE retains its own reference.
}

// ---------------------------------------------------------------------------
// MetalTopLink destructor
// ---------------------------------------------------------------------------

MetalTopLink::~MetalTopLink()
{
    releaseTE(teTexture_);
    releaseTE(teSemaphore_);
}

// ---------------------------------------------------------------------------
// OutMetalTopLink
// ---------------------------------------------------------------------------

void OutMetalTopLink::onOutputTextureChange()
{
    TouchObject<TETexture> teTex;
    TEResult result = TEInstanceLinkGetTextureValue(
        instance_, identifier_.c_str(), TELinkValueCurrent, teTex.take());

    if (result != TEResultSuccess || !teTex)
    {
        if (result != TEResultSuccess)
            spdlog::error("OutMetalTopLink::onOutputTextureChange {}: {}", name_, TEResultGetDescription(result));
        return;
    }

    if (TETextureGetType(teTex) != TETextureTypeMetal)
    {
        spdlog::error("OutMetalTopLink {}: unexpected texture type {}", name_, (int)TETextureGetType(teTex));
        return;
    }

    // Return previous texture to TouchEngine before replacing it.
    // Pass nullptr semaphore (no GPU work from our side on the old texture).
    if (teTexture_ && TEInstanceDoesTextureOwnershipTransfer(instance_))
    {
        TouchObject<TETexture> prevTex;
        prevTex.set(reinterpret_cast<TETexture*>(teTexture_));
        TEInstanceAddTextureTransfer(instance_, prevTex, nullptr, 0);
    }

    // Replace retained refs.
    releaseTE(teTexture_);
    releaseTE(teSemaphore_);
    waitValue_ = 0;

    auto* mt = static_cast<TEMetalTexture*>(teTex.get());
    TERetain(asTE(mt));
    teTexture_ = mt;

    // Get GPU sync transfer.
    if (TEInstanceHasTextureTransfer(instance_, teTex))
    {
        TouchObject<TESemaphore> semaphore;
        result = TEInstanceGetTextureTransfer(instance_, teTex, semaphore.take(), &waitValue_);
        if (result == TEResultSuccess && semaphore &&
            TESemaphoreGetType(semaphore) == TESemaphoreTypeMetal)
        {
            auto* ms = static_cast<TEMetalSemaphore*>(semaphore.get());
            TERetain(asTE(ms));
            teSemaphore_ = ms;
        }
    }

    id<MTLTexture> mtlTex = TEMetalTextureGetTexture(teTexture_);
    width_  = (size_t)[mtlTex width];
    height_ = (size_t)[mtlTex height];
}

uintptr_t OutMetalTopLink::metalTextureHandle() const
{
    if (!teTexture_) return 0;
    id<MTLTexture> tex = TEMetalTextureGetTexture(teTexture_);
    return reinterpret_cast<uintptr_t>((__bridge void*)tex);
}

uintptr_t OutMetalTopLink::sharedEventHandle() const
{
    if (!teSemaphore_) return 0;
    MTLSharedEventHandle* h = TEMetalSemaphoreGetSharedEventHandle(teSemaphore_);
    return reinterpret_cast<uintptr_t>((__bridge void*)h);
}

int OutMetalTopLink::pixelFormat() const
{
    if (!teTexture_) return 0;
    id<MTLTexture> tex = TEMetalTextureGetTexture(teTexture_);
    return (int)[tex pixelFormat];
}

std::vector<uint8_t> OutMetalTopLink::readback() const
{
    if (!teTexture_ || width_ == 0 || height_ == 0) return {};

    id<MTLTexture> tex = TEMetalTextureGetTexture(teTexture_);

    // Bytes per pixel depends on format; compute from Metal texture properties.
    NSUInteger bitsPerPixel = 0;
    switch ([tex pixelFormat])
    {
        case MTLPixelFormatBGRA8Unorm:
        case MTLPixelFormatRGBA8Unorm:
        case MTLPixelFormatBGRA8Unorm_sRGB:
        case MTLPixelFormatRGBA8Unorm_sRGB:
            bitsPerPixel = 32;  break;
        case MTLPixelFormatRGBA16Float:
            bitsPerPixel = 64;  break;
        case MTLPixelFormatRGBA32Float:
            bitsPerPixel = 128; break;
        default:
            spdlog::error("OutMetalTopLink::readback {}: unsupported pixel format {}", name_, (int)[tex pixelFormat]);
            return {};
    }

    size_t bytesPerRow  = width_ * (bitsPerPixel / 8);
    std::vector<uint8_t> pixels(height_ * bytesPerRow);

    [tex getBytes:pixels.data()
      bytesPerRow:bytesPerRow
       fromRegion:MTLRegionMake2D(0, 0, width_, height_)
      mipmapLevel:0];

    return pixels;
}

// ---------------------------------------------------------------------------
// InMetalTopLink
// ---------------------------------------------------------------------------

void InMetalTopLink::setTexture(uintptr_t mtlTextureHandle,
                                 uintptr_t sharedEventHandle,
                                 uint64_t  wv)
{
    id<MTLTexture> mtlTex = (__bridge id<MTLTexture>)(void*)mtlTextureHandle;
    if (!mtlTex) return;

    releaseTE(teTexture_);

    // ponytail: nullptr callback — TE retains mtlTex for its own lifetime
    TEMetalTexture* teTex = TEMetalTextureCreate(
        mtlTex, TETextureOriginTopLeft, kTETextureComponentMapIdentity, nullptr, nullptr);
    teTexture_ = teTex; // takes the factory-returned retained ref

    TEResult result = TEInstanceLinkSetTextureValue(
        instance_, identifier_.c_str(), reinterpret_cast<TETexture*>(teTex), nullptr);
    if (result != TEResultSuccess)
    {
        spdlog::error("InMetalTopLink::setTexture {}: {}", name_, TEResultGetDescription(result));
        return;
    }

    if (sharedEventHandle && TEInstanceDoesTextureOwnershipTransfer(instance_))
    {
        MTLSharedEventHandle* handle = (__bridge MTLSharedEventHandle*)(void*)sharedEventHandle;
        // ponytail: nullptr callback on the semaphore — only need it for one transfer call
        TEMetalSemaphore* sem = TEMetalSemaphoreCreate(handle, nullptr, nullptr);
        TouchObject<TESemaphore> teSem;
        teSem.take(reinterpret_cast<TESemaphore*>(sem));
        TEInstanceAddTextureTransfer(
            instance_, reinterpret_cast<TETexture*>(teTex), teSem, wv);
    }
}

#endif // TOUCHPY_MACOS
