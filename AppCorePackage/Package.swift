// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "FinancialAccountingApp",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AppCore",
            targets: ["AppCore"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/airbnb/lottie-ios.git", from: "4.5.2")
    ],
    targets: [
        .target(
            name: "AppCore",
            dependencies: [
                .product(name: "Lottie", package: "lottie-ios")
            ],
            path: "Sources/AppCore",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
