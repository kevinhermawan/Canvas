// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreViews",
    platforms: [.macOS(.v14)],
    products: [
        .library(
            name: "CoreViews",
            targets: ["CoreViews"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kean/Nuke.git", .upToNextMajor(from: "12.8.0")),
        .package(url: "https://github.com/kevinhermawan/ChatField.git", .upToNextMajor(from: "3.0.3"))
    ],
    targets: [
        .target(
            name: "CoreViews",
            dependencies: [
                .product(name: "Nuke", package: "Nuke"),
                .product(name: "NukeUI", package: "Nuke"),
                "ChatField"
            ])
    ]
)
