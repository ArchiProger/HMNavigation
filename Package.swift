// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HMNavigation",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NavigationSheet",
            targets: ["NavigationSheet"]),
        .library(
            name: "NavigationTabBar",
            targets: ["NavigationTabBar"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.1.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NavigationSheet",
        dependencies: [
            "NavigationTabBar"
        ]),
        .target(
            name: "NavigationTabBar"),
        .testTarget(
            name: "NavigationSheetTests",
            dependencies: ["NavigationSheet"]),
    ]
)
