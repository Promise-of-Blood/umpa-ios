import ProjectDescription

let project = Project(
  name: "AppSettingFeature",
  settings: .settings(
    base: [:
      //        "SWIFT_VERSION": "5.9",
    ],
    debug: [:],
    release: [:],
  ),
  targets: [
    .target(
      name: "AppSettingFeature",
      destinations: [.iPhone],
      product: .staticFramework,
      bundleId: "pob.Umpa.AppSettingFeature",
      deploymentTargets: .iOS("17.0"),
      sources: [
        "Sources/**/*.swift",
      ],
      dependencies: [
        .project(
          target: "BaseFeature",
          path: .relativeToRoot("Projects/Features/BaseFeature")
        ),
        .external(name: "SFSafeSymbols"),
      ],
      settings: .settings(),
    ),
  ],
)
