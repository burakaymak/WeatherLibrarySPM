// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "WeatherLibrary",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "WeatherLibrary",
            targets: ["WeatherLibrary"])
    ],
    targets: [
        .target(
            name: "WeatherLibrary",
            path: "Sources")
    ]
)

