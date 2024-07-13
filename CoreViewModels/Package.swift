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
        .package(name: "CoreModels", path: "../CoreModels"),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", .upToNextMajor(from: "4.2.2")),
        .package(url: "https://github.com/kevinhermawan/AppInfo.git", .upToNextMajor(from: "1.0.2")),
        .package(url: "https://github.com/kevinhermawan/ViewState.git", .upToNextMajor(from: "1.2.2")),
        .package(url: "https://github.com/MacPaw/OpenAI.git", .upToNextMajor(from: "0.2.9"))
    ],
    targets: [
        .target(
            name: "CoreViewModels",
            dependencies: [
                "CoreModels",
                "KeychainAccess",
                "AppInfo",
                "ViewState",
                "OpenAI"
            ]),
        .testTarget(
            name: "CoreViewModelsTests",
            dependencies: ["CoreViewModels"]),
    ]
)
