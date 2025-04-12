// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "VinUtility",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "VinUtility",
            targets: ["VinUtility"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "VinUtility",
            dependencies: []),
        .testTarget(
            name: "VinUtilityTests",
            dependencies: ["VinUtility"]),
    ]
)
