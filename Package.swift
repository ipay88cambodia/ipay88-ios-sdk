// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "IPay88Sdk",
  platforms: [
    .iOS(.v11)
  ],
  products: [
    .library(name: "IPay88Sdk", targets: ["IPay88Sdk"]),
  ],
  targets: [
    .binaryTarget(name: "IPay88Sdk", path: "./Source/IPay88Sdk.xcframework")
  ]
)
