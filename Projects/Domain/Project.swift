import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
  name: Module.domain.primaryName,
  settings: .settings(
    base: [:],
    debug: ["SWIFT_ACTIVE_COMPILATION_CONDITIONS": "$(inherited) MOCKING"],
    release: [:],
  ),
  targets: [
    .target(
      name: Module.domain.primaryName,
      destinations: [.iPhone],
      product: .staticFramework,
      bundleId: Module.domain.bundleId,
      deploymentTargets: env.deploymentTargets,
      sources: [
        "Sources/**/*.swift",
      ],
      dependencies: [
        Module.core.asDepencency,
        .external(name: "Mockable"),
      ],
      settings: .settings(),
    ),
    .target(
      name: Module.domain.primaryName + "UnitTests",
      destinations: .iOS,
      product: .unitTests,
      bundleId: "\(Module.domain.bundleId).UnitTests",
      deploymentTargets: env.deploymentTargets,
      infoPlist: .default,
      sources: [
        "Tests/TestHelpers.swift",
        "Tests/UnitTests/**/*.swift",
      ],
      dependencies: [
        Module.domain.asDepencency,
        
      ],
      settings: .settings(),
    ),
  ],
)
