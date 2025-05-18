import ProjectDescription

let project = Project(
  name: "UmpaUIKit",
  settings: .settings(
    base: [:
      //        "SWIFT_VERSION": "5.9",
    ],
    debug: [:],
    release: [:],
  ),
  targets: [
    .target(
      name: "UmpaUIKit",
      destinations: [.iPhone],
      product: .staticFramework,
      bundleId: "pob.Umpa.UmpaUIKit",
      deploymentTargets: .iOS("17.0"),
      sources: [
        "Sources/**/*.swift",
        "Preview Content/**/*.swift",
      ],
      resources: [
        "Resources/**",
      ],
      dependencies: [
        .project(
          target: "Core",
          path: .relativeToRoot("Projects/Core")
        ),
      ],
      settings: .settings(),
    ),
  ],
)
