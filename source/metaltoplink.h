#pragma once
#ifdef TOUCHPY_MACOS

#include "links.h"
#include <array>
#include <cstdint>
#include <vector>

// TEMetalTexture_ is only defined in TEMetal.h (Obj-C header); forward-declare here
// so we can store pointers in C++ without pulling in Metal headers.
struct TEMetalTexture_;
typedef struct TEMetalTexture_ TEMetalTexture;
// TEMetalSemaphore_ is already forward-declared in TouchObject.h (included via TouchEngine.h)

// Creates a TEMetalContext for the default Metal device and associates it with the instance.
// Must be called after TEInstanceCreate, before TEInstanceConfigure.
// Defined in metaltoplink.mm — Obj-C++ only.
void associateDefaultMetalContext(TEInstance* instance);


// ---------------------------------------------------------------------------
// Base
// ---------------------------------------------------------------------------

class MetalTopLink : public Link<MetalTopLink>
{
public:
    MetalTopLink(TouchObject<TEInstance> instance, TouchObject<TELinkInfo> linkInfo)
        : Link<MetalTopLink>(instance, linkInfo) {}

    ~MetalTopLink();

    size_t width()  const { return width_; }
    size_t height() const { return height_; }

protected:
    TEMetalTexture*   teTexture_   { nullptr }; // retained via TERetain
    TEMetalSemaphore* teSemaphore_ { nullptr }; // retained via TERetain
    uint64_t          waitValue_   { 0 };
    size_t            width_       { 0 };
    size_t            height_      { 0 };
};


// ---------------------------------------------------------------------------
// Output (TouchEngine → Python)
// ---------------------------------------------------------------------------

class OutMetalTopLink : public MetalTopLink
{
public:
    using MetalTopLink::MetalTopLink;

    // Called by Comp when a texture value-change event fires for this link.
    void onOutputTextureChange();

    // GPU path — zero cost. Returns id<MTLTexture> cast to uintptr_t.
    // Valid until the next frame. Caller must wait on sharedEventHandle/waitValue
    // before sampling on GPU, or call after frame_did_finish() for CPU use.
    uintptr_t metalTextureHandle() const;

    // MTLSharedEventHandle* as uintptr_t — for GPU-GPU sync (may be 0 if no transfer).
    uintptr_t sharedEventHandle() const;
    uint64_t  waitValue()         const { return waitValue_; }

    // [height, width, channels] — channels=4 for all formats we expose.
    std::array<size_t, 3> shape() const { return { height_, width_, 4u }; }

    // MTLPixelFormat enum value — use to interpret readback() bytes.
    int pixelFormat() const;

    // CPU readback — blocks until GPU work is done. Raw bytes in native pixel format.
    // Use pixelFormat() to interpret. Safe to call after frame_did_finish().
    std::vector<uint8_t> readback() const;
};

class OutMetalTopLinks : public Links<OutMetalTopLinks, OutMetalTopLink>
{
public:
    OutMetalTopLinks() = default;
    explicit OutMetalTopLinks(TouchObject<TEInstance> instance)
        : Links<OutMetalTopLinks, OutMetalTopLink>(instance) {}

    void addLink(TouchObject<TELinkInfo> linkInfo) override
    {
        links_.push_back(std::make_unique<OutMetalTopLink>(instance_, linkInfo));
        nameMap_[linkInfo->name]             = links_.back().get();
        identifierMap_[linkInfo->identifier] = links_.back().get();
    }
};


// ---------------------------------------------------------------------------
// Input (Python → TouchEngine)
// ---------------------------------------------------------------------------

class InMetalTopLink : public MetalTopLink
{
public:
    using MetalTopLink::MetalTopLink;

    // Set an MTLTexture as input to this TOP link.
    // mtlTextureHandle  : uintptr_t of id<MTLTexture> (bridged void*)
    // sharedEventHandle : uintptr_t of MTLSharedEventHandle* (0 = no GPU sync)
    // waitValue         : semaphore wait value (ignored if sharedEventHandle is 0)
    void setTexture(uintptr_t mtlTextureHandle,
                    uintptr_t sharedEventHandle = 0,
                    uint64_t  waitValue = 0);
};

class InMetalTopLinks : public Links<InMetalTopLinks, InMetalTopLink>
{
public:
    InMetalTopLinks() = default;
    explicit InMetalTopLinks(TouchObject<TEInstance> instance)
        : Links<InMetalTopLinks, InMetalTopLink>(instance) {}

    void addLink(TouchObject<TELinkInfo> linkInfo) override
    {
        links_.push_back(std::make_unique<InMetalTopLink>(instance_, linkInfo));
        nameMap_[linkInfo->name]             = links_.back().get();
        identifierMap_[linkInfo->identifier] = links_.back().get();
    }
};

#endif // TOUCHPY_MACOS
