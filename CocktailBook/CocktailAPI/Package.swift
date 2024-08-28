// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CocktailAPI",
    platforms: [
        .iOS(.v13) // Ensure this is set to iOS 13 or later
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CocktailAPI",
            targets: ["CocktailAPI"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CocktailAPI",
            resources: [
                .process("Resources")
            ]),
        .testTarget(
            name: "CocktailAPITests",
            dependencies: ["CocktailAPI"]),
    ]
)
