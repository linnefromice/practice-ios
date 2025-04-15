// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MultiModules",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CoreDesignSystem",
            targets: ["CoreDesignSystem"]),
        .library(
            name: "CoreComponents",
            targets: ["CoreComponents"]),
        // .library(
        //     name: "CoreCamera",
        //     targets: ["CoreCamera"]),
        .library(
            name: "FeatureChat",
            targets: ["FeatureChat"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CoreDesignSystem"),
        .target(
            name: "CoreComponents"),
        .testTarget(
            name: "CoreComponentsTests",
            dependencies: ["CoreComponents"]
        ),
        // .target(
        //     name: "CoreCamera"),
        .target(
            name: "FeatureChat",
            dependencies: ["CoreComponents"]),
            
    ]
)
