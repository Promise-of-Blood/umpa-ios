// Created for Umpa in 2025

import Foundation

public protocol NetworkResponse: Decodable {}

extension Array: NetworkResponse where Element: Decodable {}
