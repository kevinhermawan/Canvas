// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreViewModels",
    platforms: [.macOS(.v14)],
    products: [
        .library(
            name: "CoreViewModels",
            targets: ["CoreViewModels"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", .upToNextMajor(from: "4.2.2")),
        .package(url: "https://github.com/kevinhermawan/ViewState.git", .upToNextMajor(from: "1.2.1")),
        .package(url: "https://github.com/MacPaw/OpenAI.git", branch: "main")
    ],
    targets: [
        .target(
            name: "CoreViewModels",
            dependencies: ["KeychainAccess", "OpenAI", "ViewState"]),
        .testTarget(
            name: "CoreViewModelsTests",
            dependencies: ["CoreViewModels"]),
    ]
)
