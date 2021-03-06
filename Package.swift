// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TradingApp",
    products: [
      .executable(name: "TradingApp", targets: ["TradingApp"]),
      .library(name: "TradingEngine", targets: ["TradingEngine"]),
      ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
      .package(url: "https://github.com/yaslab/CSV.swift.git", .upToNextMinor(from: "2.1.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "TradingApp",
            dependencies: ["TradingEngine"]),
        .target(
            name: "TradingEngine",
            dependencies: ["CSV"]),
        .testTarget(
            name: "TradingAppTests",
            dependencies: ["TradingEngine"]),
    ]
)
