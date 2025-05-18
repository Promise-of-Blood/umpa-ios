import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
  name: Module.umpa.primaryName,
  settings: .settings(
    base: [:],
    debug: ["SWIFT_ACTIVE_COMPILATION_CONDITIONS": "$(inherited) MOCKING"],
    release: [:],
  ),
  targets: [
    .target(
      name: Module.umpa.primaryName,
      destinations: [.iPhone],
      product: .app,
      bundleId: Module.umpa.bundleId,
      deploymentTargets: env.deploymentTargets,
      infoPlist: .file(path: .relativeToManifest("Info.plist")),
      sources: [
        "Sources/**/*.swift",
        "Preview Content/**/*.swift",
      ],
      resources: [
        "Resources/**",
        "Preview Content/Resources/**",
      ],
      dependencies: [
        Module.core.asDepencency,
        Module.domain.asDepencency,
        Module.dataAccess.asDepencency,
        Module.umpaUIKit.asDepencency,
        .external(name: "Factory"),
        .external(name: "SFSafeSymbols"),
        .external(name: "Mockable"),
        .external(name: "GoogleSignIn"),
        .external(name: "GoogleSignInSwift"),
        .external(name: "KakaoSDK"),
        .external(name: "KakaoSDKAuth"),
        .external(name: "KakaoSDKUser"),
        .external(name: "NidThirdPartyLogin"),
      ]
        + Module.features.map(\.asDepencency),
      settings: .settings(
        configurations: [
          .debug(name: "DEBUG", xcconfig: .relativeToManifest("Config/Debug.xcconfig")),
          .release(name: "RELEASE", xcconfig: .relativeToManifest("Config/Release.xcconfig")),
        ]
      ),
    ),
    .target(
      name: Module.umpa.primaryName + "UnitTests",
      destinations: .iOS,
      product: .unitTests,
      bundleId: "\(Module.umpa.bundleId).UnitTests",
      deploymentTargets: env.deploymentTargets,
      infoPlist: .default,
      sources: [
        "Tests/TestHelpers.swift",
        "Tests/UnitTests/**/*.swift",
      ],
      dependencies: [
        Module.umpa.asDepencency,

      ],
      settings: .settings(),
    ),
  ],
  additionalFiles: [
    .glob(pattern: .relativeToManifest("Config/Common.xcconfig")),
    .glob(pattern: .relativeToManifest("Config/Secrets.xcconfig")),
  ],
)
