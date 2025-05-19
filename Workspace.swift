import ProjectDescription
import ProjectDescriptionHelpers

let workspace = Workspace(
  name: env.projectName,
  projects: [
    "Projects/Umpa",
  ],
  fileHeaderTemplate: .string("Created for \(env.projectName) in ___YEAR___"),
)
