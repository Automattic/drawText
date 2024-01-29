// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "drawText",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .executable(
            name: "drawText",
            targets: ["drawText"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(name: "drawText"),
        .testTarget(
            name: "drawTextTests",
            dependencies: ["drawText"],
            resources: [
                .copy("Test Cases/default-stylesheet.txt"),
                .copy("Test Cases/external-styles-sample.css"),
                .copy("Test Cases/external-styles-test.txt"),
                .copy("Test Cases/large-text-block.txt"),
                .copy("Test Cases/regular-text-block.txt"),
                .copy("Test Cases/rtl-text-block.txt"),
                .copy("Test Cases/text-size-adjustment-test.txt"),
            ]
        ),
    ]
)
