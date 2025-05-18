import ProjectDescription

let project = Project(
  name: "Core",
  settings: .settings(
    base: [:
      //        "SWIFT_VERSION": "5.9",
    ],
    debug: [:],
    release: [:],
  ),
  targets: [
    .target(
      name: "Core",
      destinations: [.iPhone],
      product: .staticFramework,
      bundleId: "pob.Umpa.Core",
      deploymentTargets: .iOS("17.0"),
      sources: [
        "Sources/**/*.swift",
      ],
      dependencies: [],
      settings: .settings(),
    ),
  ],
)
