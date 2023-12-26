// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ImageGenerationModule",
    platforms: [.macOS(.v14)],
    products: [
        .library(
            name: "ImageGenerationModule",
            targets: ["ImageGenerationModule"]),
    ],
    dependencies: [
        .package(name: "CoreModels", path: "../CoreModels"),
        .package(name: "CoreViewModels", path: "../CoreViewModels"),
        .package(name: "CoreViews", path: "../CoreViews")
    ],
    targets: [
        .target(
            name: "ImageGenerationModule",
            dependencies: [
                "CoreModels",
                "CoreViewModels",
                "CoreViews"
            ]),
        .testTarget(
            name: "ImageGenerationModuleTests",
            dependencies: ["ImageGenerationModule"]),
    ]
)
