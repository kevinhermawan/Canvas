// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SettingsModule",
    platforms: [.macOS(.v14)],
    products: [
        .library(
            name: "SettingsModule",
            targets: ["SettingsModule"]),
    ],
    dependencies: [
        .package(url: "https://github.com/sindresorhus/Defaults.git", .upToNextMajor(from: "7.3.1"))
    ],
    targets: [
        .target(
            name: "SettingsModule",
            dependencies: ["Defaults"]),
        .testTarget(
            name: "SettingsModuleTests",
            dependencies: ["SettingsModule"]),
    ]
)
