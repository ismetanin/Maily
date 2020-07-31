// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Maily",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "Maily",
            targets: ["Maily"]
        )
    ],
    targets: [
        .target(
            name: "Maily"
        ),
        .testTarget(
            name: "MailyTests",
            dependencies: ["Maily"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
