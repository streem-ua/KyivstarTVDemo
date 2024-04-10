// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Presentation",
            targets: ["Presentation"]),
        .library(
            name: "Data",
            targets: ["Data"]),
        .library(
            name: "Domain",
            targets: ["Domain"]),
        .library(
            name: "Core",
            targets: ["Core"])
        
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Presentation",
            dependencies: ["Domain"]),
        .target(
            name: "Core"),
        .target(
            name: "Domain",
            dependencies: ["Data"]),
        .target(
            name: "Data",
            dependencies: ["Core"]),
        .testTarget(
            name: "ModulesTests",
            dependencies: ["Presentation"])
    ]
)
