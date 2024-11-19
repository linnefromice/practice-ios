// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Sample",
    platforms: [
        .iOS(.v15),
        .macOS(.v11)
    ],
    products: [
        .library(name: "AppFeature", targets: ["AppFeature"])
    ],
    targets: [
        .target(name: "AppFeature")
    ]
)
