# CMakeList.txt : CMake project for touchpy
#
cmake_minimum_required(VERSION 3.21...3.31)

if(SKBUILD)
    message(STATUS "Building via scikit-build-core")
endif()

# Enable Hot Reload for MSVC compilers if supported.
if(POLICY CMP0141)
  cmake_policy(SET CMP0141 NEW)
  set(CMAKE_MSVC_DEBUG_INFORMATION_FORMAT "$<IF:$<AND:$<C_COMPILER_ID:MSVC>,$<CXX_COMPILER_ID:MSVC>>,$<$<CONFIG:Debug,RelWithDebInfo>:EditAndContinue>,$<$<CONFIG:Debug,RelWithDebInfo>:ProgramDatabase>>")
endif()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_CXX_EXTENSIONS OFF)

# Platform detection — must precede project() for language selection.
# CMAKE_HOST_SYSTEM_NAME is reliable pre-project(); CMAKE_SYSTEM_NAME is not.
# On macOS: OBJCXX, no CUDA. On Windows: CUDA required.
if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Darwin")
    set(TOUCHPY_MACOS ON)
    set(_TOUCHPY_LANGUAGES CXX OBJCXX)
else()
    set(TOUCHPY_MACOS OFF)
    set(CMAKE_CUDA_ARCHITECTURES 75 80 86 89)
    set(CMAKE_CUDA_STANDARD 17)
    set(CMAKE_CUDA_STANDARD_REQUIRED True)
    set(_TOUCHPY_LANGUAGES CXX CUDA)
endif()

if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build." FORCE)
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

project("TouchPy" LANGUAGES ${_TOUCHPY_LANGUAGES})

set(SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/source)

file(GLOB_RECURSE CPP_SOURCES "${SOURCE_DIR}/*.cpp" "${SOURCE_DIR}/*.c" "${SOURCE_DIR}/*.h")
list(FILTER CPP_SOURCES EXCLUDE REGEX ".*gtest\.cpp$")
list(FILTER CPP_SOURCES EXCLUDE REGEX ".*main\.cpp$")

if(TOUCHPY_MACOS)
    # Exclude GPU-specific subtrees: Vulkan renderer (vri/), CUDA memory, texture
    # interop, and TOP link — none compile without CUDA/Vulkan SDK headers.
    # Source-level #ifdef __APPLE__ guards in comp.h / toplink.h are the follow-on
    # task; these CMake exclusions define the macOS translation unit boundary.
    list(FILTER CPP_SOURCES EXCLUDE REGEX ".*/vri/.*")
    list(FILTER CPP_SOURCES EXCLUDE REGEX ".*/renderer\.(cpp|h)$")
    list(FILTER CPP_SOURCES EXCLUDE REGEX ".*/texture\.(cpp|h)$")
    list(FILTER CPP_SOURCES EXCLUDE REGEX ".*/cudamemory\.(cpp|h)$")
    list(FILTER CPP_SOURCES EXCLUDE REGEX ".*/toplink\.(cpp|h)$")
    list(FILTER CPP_SOURCES EXCLUDE REGEX ".*/copykernels\.(cu|cuh)$")
    list(FILTER CPP_SOURCES EXCLUDE REGEX ".*/cudadatatypes\.h$")
    list(FILTER CPP_SOURCES EXCLUDE REGEX ".*/cudaflags\.h$")
    list(FILTER CPP_SOURCES EXCLUDE REGEX ".*/deviceinfo\.h$")
    list(FILTER CPP_SOURCES EXCLUDE REGEX ".*common/cuda_helpers\.h$")
else()
    file(GLOB_RECURSE CUDA_SOURCES "${SOURCE_DIR}/*.cu" "${SOURCE_DIR}/*.cuh")
endif()

# print all sources if on
set(PRINT_SOURCE_FILES Off)
if(PRINT_SOURCE_FILES)
    foreach(source IN LISTS CPP_SOURCES)
      message(STATUS "touchpy source: ${source}")
    endforeach()
endif()

# Compile definitions
if(WIN32)
    list(APPEND COMPILE_DEFINITIONS
        WIN32_LEAN_AND_MEAN
        NOMINMAX
        _UNICODE
        UNICODE
        VK_USE_PLATFORM_WIN32_KHR
    )
endif()
if(TOUCHPY_MACOS)
    list(APPEND COMPILE_DEFINITIONS TOUCHPY_MACOS)
endif()

include(FetchContent)

# TouchEngine SDK — platform-specific paths and link strategy
if(TOUCHPY_MACOS)
    set(TOUCHENGINE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/external/TouchEngine-macOS")
    set(TOUCHENGINE_FRAMEWORK "${TOUCHENGINE_DIR}/TouchEngine.framework")
    if(NOT EXISTS "${TOUCHENGINE_FRAMEWORK}")
        message(FATAL_ERROR
            "TouchEngine.framework not found at ${TOUCHENGINE_FRAMEWORK}\n"
            "Run: git submodule update --init")
    endif()
    message(STATUS "TouchEngine.framework: ${TOUCHENGINE_FRAMEWORK}")
else()
    find_package(Vulkan REQUIRED)
    message(STATUS Vulkan_INCLUDE_DIR=${Vulkan_INCLUDE_DIR})

    find_package(CUDAToolkit REQUIRED)
    message(STATUS CUDAToolkit_INCLUDE_DIRS=${CUDAToolkit_INCLUDE_DIRS})

    FetchContent_Declare(
      VulkanMemoryAllocator
      GIT_REPOSITORY https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator.git
      GIT_TAG v3.1.0
      CONFIGURE_COMMAND ""
      BUILD_COMMAND ""
    )
    FetchContent_MakeAvailable(VulkanMemoryAllocator)

    # Source includes VMA as "vma/vk_mem_alloc.h" (matching Vulkan SDK layout)
    # but the VMA repo puts it at include/vk_mem_alloc.h — create the expected structure
    file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/_vma_include/vma")
    file(COPY "${vulkanmemoryallocator_SOURCE_DIR}/include/vk_mem_alloc.h"
         DESTINATION "${CMAKE_BINARY_DIR}/_vma_include/vma")
endif()

FetchContent_Declare(
  spdlog
  GIT_REPOSITORY https://github.com/gabime/spdlog.git
  GIT_TAG v1.15.0
)
FetchContent_MakeAvailable(spdlog)

# touchpy
#################################################################################################
find_package(Python 3.9
    REQUIRED COMPONENTS Interpreter Development.Module
    OPTIONAL_COMPONENTS Development.SABIModule
)

message(STATUS "Python executable: ${Python_EXECUTABLE}")
if(DEFINED Python_SOABI)
    message(STATUS "Python SOABI: ${Python_SOABI}")
endif()

# Detect nanobind CMake dir from the installed Python package
execute_process(
  COMMAND "${Python_EXECUTABLE}" -m nanobind --cmake_dir
  OUTPUT_STRIP_TRAILING_WHITESPACE OUTPUT_VARIABLE nanobind_ROOT)
find_package(nanobind CONFIG REQUIRED)

# Add nanobind module
nanobind_add_module(touchpy NB_DOMAIN NOMINSIZE ${CPP_SOURCES})
target_compile_definitions(touchpy PRIVATE ${COMPILE_DEFINITIONS})

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_compile_definitions(touchpy PRIVATE DISABLE_DEBUG_BUILD)
endif()

if(TOUCHPY_MACOS)
    target_include_directories(touchpy PRIVATE
        ${SOURCE_DIR}
        "${TOUCHENGINE_FRAMEWORK}/Headers"
    )
    target_link_libraries(touchpy PRIVATE
        "${TOUCHENGINE_FRAMEWORK}/TouchEngine"
        spdlog::spdlog
        "-framework Metal"
        "-framework Foundation"
    )
    set_target_properties(touchpy PROPERTIES
        BUILD_RPATH "@loader_path"
        INSTALL_RPATH "@loader_path"
    )
    install(TARGETS touchpy LIBRARY DESTINATION touchpy)
    install(DIRECTORY "${TOUCHENGINE_FRAMEWORK}"
        DESTINATION touchpy
        USE_SOURCE_PERMISSIONS
    )
else()
    # Create a static library for CUDA sources
    add_library(touchpy_cuda STATIC ${CUDA_SOURCES})
    set_target_properties(touchpy_cuda PROPERTIES LINKER_LANGUAGE CUDA)

    target_include_directories(touchpy PRIVATE
        ${SOURCE_DIR}
        ${CUDAToolkit_INCLUDE_DIRS}
        "${CMAKE_CURRENT_SOURCE_DIR}/external/TouchEngine-Windows/include"
        "${CMAKE_BINARY_DIR}/_vma_include"
    )
    target_link_directories(touchpy PRIVATE
        "${CMAKE_CURRENT_SOURCE_DIR}/external/TouchEngine-Windows/lib"
    )
    target_link_libraries(touchpy PRIVATE
        touchpy_cuda
        TouchEngine
        Vulkan::Vulkan
        spdlog::spdlog
    )

    if(MSVC)
        target_compile_options(touchpy PRIVATE /wd4819)
    endif()

    install(TARGETS touchpy LIBRARY DESTINATION touchpy)
    install(FILES
        "${CMAKE_CURRENT_SOURCE_DIR}/external/TouchEngine-Windows/bin/TouchEngine.dll"
        "${CUDAToolkit_BIN_DIR}/cudart64_12.dll"
        DESTINATION touchpy
    )
endif()

# touchpygtest
#################################################################################################
if(NOT SKBUILD)
    FetchContent_Declare(
      googletest
      GIT_REPOSITORY https://github.com/google/googletest.git
      GIT_TAG v1.15.2
    )
    # For Windows: Prevent overriding the parent project's compiler/linker settings
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
    FetchContent_MakeAvailable(googletest)

    set(GTEST_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/test/gtest)
    file(GLOB_RECURSE TEST_SOURCES "${GTEST_SOURCE_DIR}/*gtest*.cpp")

    set(TOUCHPY_TEST_SOURCES ${CPP_SOURCES})
    list(FILTER TOUCHPY_TEST_SOURCES EXCLUDE REGEX ".*py\.cpp$")
    add_executable(touchpygtest ${TEST_SOURCES} ${TOUCHPY_TEST_SOURCES})

    target_compile_definitions(touchpygtest PRIVATE ${COMPILE_DEFINITIONS})

    if(TOUCHPY_MACOS)
        target_include_directories(touchpygtest PRIVATE
            ${SOURCE_DIR}
            "${TOUCHENGINE_FRAMEWORK}/Headers"
        )
        target_link_libraries(touchpygtest PRIVATE
            GTest::gtest_main
            "${TOUCHENGINE_FRAMEWORK}/TouchEngine"
            spdlog::spdlog
            "-framework Metal"
            "-framework Foundation"
        )
    else()
        target_include_directories(touchpygtest PRIVATE
            ${SOURCE_DIR}
            ${CUDAToolkit_INCLUDE_DIRS}
            "${CMAKE_CURRENT_SOURCE_DIR}/external/TouchEngine-Windows/include"
        )
        target_link_directories(touchpygtest PRIVATE
            ${CMAKE_CURRENT_SOURCE_DIR}/external/TouchEngine-Windows/lib
        )
        target_link_libraries(touchpygtest PRIVATE
            GTest::gtest_main
            touchpy_cuda
            TouchEngine
            Vulkan::Vulkan
            spdlog::spdlog
        )
    endif()

    include(GoogleTest)
    gtest_discover_tests(touchpygtest)
    add_definitions(-DCMAKE_PROJECT_DIR="${CMAKE_SOURCE_DIR}")
endif()
