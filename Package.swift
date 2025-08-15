// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "FA-Financial-Accounting-",
    platforms: [
        .iOS(.v15)
    ],
    dependencies: [
        .package(url: "https://github.com/airbnb/lottie-ios.git", from: "4.5.2")
    ],
    targets: [
        .target(
            name: "FA-Financial-Accounting-",
            dependencies: ["Lottie"]
        )
    ]
)
