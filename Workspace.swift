import ProjectDescription

let workspace = Workspace(
  name: "Umpa",
  projects: [
    "Projects/Umpa",
  ],
  fileHeaderTemplate: .string("Created for ___PROJECTNAME___ in ___YEAR___"),
)
