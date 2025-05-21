import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
  name: Module.baseFeature.primaryName,
  settings: .settings(),
  targets: [
    .target(
      name: Module.baseFeature.primaryName,
      destinations: [.iPhone],
      product: .staticFramework,
      bundleId: Module.baseFeature.bundleId,
      deploymentTargets: env.deploymentTargets,
      sources: [
        "Sources/**/*.swift",
        "Preview Content/**/*.swift",
      ],
      dependencies: [
        Module.umpaUIKit.asDepencency,
        Module.domain.asDepencency,
        .external(name: "Factory"),
        .external(name: "SFSafeSymbols"),
      ],
      settings: .settings(),
    ),
  ],
)
