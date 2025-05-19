import ProjectDescription

public let env = Env()

public struct Env: Sendable {
  public let bundleIdPrefix = "com.pob"
  public let deploymentTargets: DeploymentTargets = .iOS("17.0")
  public let projectName = "Umpa"
}

public enum Module: Sendable {
  case umpa
  case domain
  case core
  case dataAccess
  case umpaUIKit
  case appSettingFeature
  case baseFeature
  case myServiceFeature

  public var primaryName: String {
    switch self {
    case .umpa:
      "Umpa"
    case .domain:
      "Domain"
    case .core:
      "Core"
    case .dataAccess:
      "DataAccess"
    case .umpaUIKit:
      "UmpaUIKit"
    case .appSettingFeature:
      "AppSettingFeature"
    case .baseFeature:
      "BaseFeature"
    case .myServiceFeature:
      "MyServiceFeature"
    }
  }

  public var asDepencency: TargetDependency {
    switch self {
    case .domain, .core, .umpaUIKit, .dataAccess, .umpa:
      .project(
        target: primaryName,
        path: .relativeToRoot("Projects/\(primaryName)")
      )
    case .baseFeature, .appSettingFeature, .myServiceFeature:
      .project(
        target: primaryName,
        path: .relativeToRoot("Projects/Features/\(primaryName)")
      )
    }
  }

  public var bundleId: String {
    "\(env.bundleIdPrefix).\(primaryName)"
  }

  public static let features: [Module] = [
    .baseFeature,
    .myServiceFeature,
    .appSettingFeature,
  ]
}
