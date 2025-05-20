import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
  name: Module.appSettingFeature.primaryName,
  settings: .settings(),
  targets: [
    .target(
      name: Module.appSettingFeature.primaryName,
      destinations: [.iPhone],
      product: .staticFramework,
      bundleId: Module.appSettingFeature.bundleId,
      deploymentTargets: env.deploymentTargets,
      sources: [
        "Sources/**/*.swift",
      ],
      dependencies: [
        Module.baseFeature.asDepencency,
        .external(name: "SFSafeSymbols"),
      ],
      settings: .settings(),
    ),
  ],
)
