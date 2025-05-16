// Created for Umpa in 2025

import SwiftUI

public struct IndexingForEach<Data: RandomAccessCollection, Content: View>: View where Data.Index: Hashable {
  let data: Data
  let content: (Data.Index, Data.Element) -> Content

  public init(_ data: Data, @ViewBuilder content: @escaping (_ index: Data.Index, Data.Element) -> Content) {
    self.data = data
    self.content = content
  }

  public var body: some View {
    ForEach(Array(zip(data.indices, data)), id: \.0) { index, element in
      content(index, element)
    }
  }
}
