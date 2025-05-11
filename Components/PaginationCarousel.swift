// Created for Umpa in 2025

import SwiftUI

public struct PaginationCarousel<Content, P>: View where Content: View, P: Pagination {
  @Binding private var currentIndex: Int

  private let pagination: P
  private let paginationOffset: CGFloat
  private let defaultPaginationOffset: CGFloat = 10

  @ViewBuilder let content: () -> Content

  public init(
    pagination: P,
    paginationOffset: CGFloat = 0,
    @ViewBuilder content: @escaping () -> Content
  ) {
    _currentIndex = pagination.currentIndex
    self.pagination = pagination
    self.paginationOffset = paginationOffset
    self.content = content
  }

  /// 기본 `Pagination`을 사용하여 `Carousel`을 생성합니다.
  public init(
    currentIndex: Binding<Int>,
    pageCount: Int,
    paginationOffset: CGFloat = 0,
    @ViewBuilder content: @escaping () -> Content
  ) where P == DotsPagination {
    _currentIndex = currentIndex
    pagination = DotsPagination(currentIndex: currentIndex, pageCount: pageCount)
    self.paginationOffset = paginationOffset
    self.content = content
  }

  public init<Source>(
    currentIndex: Binding<Int>,
    paginationOffset: CGFloat = 0,
    pageSource: [Source],
    pageBuilder: @escaping (Source) -> some View
  ) where P == DotsPagination, Content == AnyView {
    _currentIndex = currentIndex
    self.paginationOffset = paginationOffset
    pagination = DotsPagination(currentIndex: currentIndex, pageCount: pageSource.count)
    let pages = {
      AnyView(
        ForEach(Array(zip(pageSource.indices, pageSource)), id: \.0) { index, source in
          pageBuilder(source)
            .tag(index)
        }
      )
    }
    content = pages
  }

  public init<Source>(
    pagination: P,
    paginationOffset: CGFloat = 0,
    pageSource: [Source],
    pageBuilder: @escaping (Source) -> some View
  ) where Content == AnyView {
    _currentIndex = pagination.currentIndex
    self.paginationOffset = paginationOffset
    self.pagination = pagination
    let pages = {
      AnyView(
        ForEach(Array(zip(pageSource.indices, pageSource)), id: \.0) { index, source in
          pageBuilder(source)
            .tag(index)
        }
      )
    }
    content = pages
  }

  public var body: some View {
    VStack(spacing: defaultPaginationOffset + paginationOffset) {
      TabView(selection: $currentIndex.animation()) {
        content()
      }
      .tabViewStyle(.page(indexDisplayMode: .never))

      pagination
    }
  }
}

#Preview {
  @Previewable @State var index = 0

  let colors: [Color] = [.red, .blue, .yellow]

  // 1: Default
  PaginationCarousel(currentIndex: $index, pageCount: colors.count) {
    ForEach(0 ..< colors.count, id: \.self) { index in
      VStack {
        Text("페이지 \(index + 1)")
          .font(.title)
        Image(systemName: "\(index + 1).circle.fill")
          .font(.system(size: 50))
      }
      .padding(40)
      .background(colors[index].opacity(0.3))
      .tag(index)
    }
  }
  .frame(width: 300, height: 200)
  .padding()

  // 2: Custom Pagination
  let appearance = DotsPagination.Appearance(
    size: 10,
    spacing: 10,
    normalColor: .white,
    highlightColor: .black,
    highlightScale: 1.6
  )
  let customPagination = DotsPagination(
    currentIndex: $index,
    pageCount: colors.count,
    appearance: appearance
  )
  PaginationCarousel(pagination: customPagination) {
    ForEach(0 ..< colors.count, id: \.self) { index in
      colors[index]
        .tag(index)
    }
  }
  .frame(width: 300, height: 220)
  .padding()
}
