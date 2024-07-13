// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreModels",
    platforms: [.macOS(.v14)],
    products: [
        .library(
            name: "CoreModels",
            targets: ["CoreModels"]),
    ],
    dependencies: [
        .package(url: "https://github.com/MacPaw/OpenAI.git", .upToNextMajor(from: "0.2.9")),
        .package(url: "https://github.com/sindresorhus/Defaults.git", .upToNextMajor(from: "8.2.0"))
    ],
    targets: [
        .target(
            name: "CoreModels",
            dependencies: ["OpenAI", "Defaults"]),
        .testTarget(
            name: "CoreModelsTests",
            dependencies: ["CoreModels"]),
    ]
)
