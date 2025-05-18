import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
  name: Module.dataAccess.primaryName,
  settings: .settings(
    base: [:],
    debug: [:],
    release: [:],
  ),
  targets: [
    .target(
      name: Module.dataAccess.primaryName,
      destinations: [.iPhone],
      product: .staticFramework,
      bundleId: Module.dataAccess.bundleId,
      deploymentTargets: env.deploymentTargets,
      sources: [
        "Sources/**/*.swift",
      ],
      dependencies: [
        Module.domain.asDepencency,
        Module.core.asDepencency,
      ],
      settings: .settings(),
    ),
    .target(
      name: Module.dataAccess.primaryName + "UnitTests",
      destinations: .iOS,
      product: .unitTests,
      bundleId: "\(Module.dataAccess.bundleId).UnitTests",
      deploymentTargets: env.deploymentTargets,
      infoPlist: .default,
      sources: [
        "Tests/TestHelpers.swift",
        "Tests/UnitTests/**/*.swift",
      ],
      dependencies: [
        Module.dataAccess.asDepencency,

      ],
      settings: .settings(),
    ),
  ],
)
