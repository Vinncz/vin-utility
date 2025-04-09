// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "vin-utility",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "vin-utility",
            targets: ["vin-utility"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "vin-utility",
            dependencies: []),
        .testTarget(
            name: "vin-utilityTests",
            dependencies: ["vin-utility"]),
    ]
)
