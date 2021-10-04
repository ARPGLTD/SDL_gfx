// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

struct TargetConfiguration {
    var cflags : [CSetting] = []
    var lflags : [LinkerSetting] = []
    var sourcePaths : [String] = []
    var excludePaths : [String] = []
}

var gfxConfig = TargetConfiguration(
    sourcePaths: [
        "src/SDL2_framerate.c",
        "src/SDL2_gfxPrimitives.c",
        "src/SDL2_imageFilter.c",
        "src/SDL2_rotozoom.c"
    ]
)

#if os(macOS)

gfxConfig.cflags = [
    // .define("SDL_IMAGE_USE_COMMON_BACKEND", to: "1"),
    // .define("LOAD_BMP", to: "1"),
]

#elseif os(Linux)

gfxConfig.cflags = [
    // .define("SDL_IMAGE_USE_COMMON_BACKEND", to: "1"),
    // .define("LOAD_BMP", to: "1"),
]

#elseif os(Windows)

gfxConfig.cflags = [
    // .define("SDL_IMAGE_USE_COMMON_BACKEND", to: "1"),
    // .define("LOAD_BMP", to: "1"),
    .define("DLL_EXPORT", to: "1"),
    .unsafeFlags(["-msse3"]),
]

gfxConfig.lflags = [
    .linkedLibrary("swiftCore"),
    .linkedLibrary("USER32"),
    .linkedLibrary("ucrt"),
    .linkedLibrary("VCRUNTIME"),
]

#endif

gfxConfig.cflags += [
    .unsafeFlags(["-Wno-everything"]),
]

let package = Package(
    name: "SDL_gfx",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "SDL_gfx", type: .dynamic, targets: ["SDL_gfx"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "SDL", url: "git@github.com:ARPGLTD/SDL.git", .branch("SwiftPackage")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SDL_gfx",
            dependencies: ["SDL"],
            exclude: gfxConfig.excludePaths,
            sources: gfxConfig.sourcePaths,
            publicHeadersPath: "Include",
            cSettings: gfxConfig.cflags,
            linkerSettings: gfxConfig.lflags
            ),
        .testTarget(
            name: "SDL_gfx_Tests",
            dependencies: ["SDL_gfx", "SDL"]
            ),
    ]
)
