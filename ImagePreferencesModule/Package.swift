// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ImagePreferencesModule",
    platforms: [.macOS(.v14)],
    products: [
        .library(
            name: "ImagePreferencesModule",
            targets: ["ImagePreferencesModule"]),
    ],
    dependencies: [
        .package(name: "CoreExtensions", path: "../CoreExtensions"),
        .package(name: "CoreModels", path: "../CoreModels"),
        .package(name: "CoreViewModels", path: "../CoreViewModels"),
        .package(name: "CoreViews", path: "../CoreViews"),
        .package(url: "https://github.com/kevinhermawan/ViewCondition.git", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(
            name: "ImagePreferencesModule",
            dependencies: [
                "CoreExtensions",
                "CoreModels",
                "CoreViewModels",
                "CoreViews",
                "ViewCondition"
            ]),
        .testTarget(
            name: "ImagePreferencesModuleTests",
            dependencies: ["ImagePreferencesModule"]),
    ]
)
