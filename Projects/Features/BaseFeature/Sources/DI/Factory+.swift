// Created for Umpa in 2025

import Factory

extension Container {
  public var appState: Factory<AppState> {
    Factory(self) { AppState() }
      .scope(.singleton)
  }
}
