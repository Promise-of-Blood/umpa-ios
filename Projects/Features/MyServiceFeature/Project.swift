import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
  name: Module.myServiceFeature.primaryName,
  settings: .settings(
    base: [:],
    debug: [:],
    release: [:],
  ),
  targets: [
    .target(
      name: Module.myServiceFeature.primaryName,
      destinations: [.iPhone],
      product: .staticFramework,
      bundleId: Module.myServiceFeature.bundleId,
      deploymentTargets: env.deploymentTargets,
      sources: [
        "Sources/**/*.swift",
      ],
      dependencies: [
        Module.baseFeature.asDepencency,
      ],
      settings: .settings(),
    ),
  ],
)
