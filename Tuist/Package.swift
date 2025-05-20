// swift-tools-version: 5.9
import PackageDescription

#if TUIST
import ProjectDescription

let packageSettings = PackageSettings(
  // Customize the product types for specific package product
  // Default is .staticFramework
  // productTypes: ["Alamofire": .framework,]
  productTypes: [:],
)
#endif

let package = Package(
  name: "MyApp",
  dependencies: [
    .package(url: "https://github.com/SFSafeSymbols/SFSafeSymbols.git", from: "6.2.0"),
    .package(url: "https://github.com/hmlongco/Factory.git", from: "2.4.3"),
    .package(url: "https://github.com/google/GoogleSignIn-iOS", from: "8.0.0"),
    .package(url: "https://github.com/kakao/kakao-ios-sdk", from: "2.24.0"),
    .package(url: "https://github.com/Kolos65/Mockable.git", from: "0.3.1"),
    .package(url: "https://github.com/naver/naveridlogin-sdk-ios-swift", from: "5.0.1"),
    .package(url: "https://github.com/apple/swift-collections.git", from: "1.2.0"),
  ]
)
