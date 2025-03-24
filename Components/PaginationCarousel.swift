// Created for Umpa in 2025

import SwiftUI

public struct PaginationCarousel<Content, P>: View where Content: View, P: Pagination {
    @Binding private var currentIndex: Int
    
    private let pagination: P
    private let paginationOffset: CGFloat
    
    @ViewBuilder let content: () -> Content
    
    public init(
        pagination: P,
        paginationOffset: CGFloat = 20,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._currentIndex = pagination.currentIndex
        self.pagination = pagination
        self.paginationOffset = paginationOffset
        self.content = content
    }
    
    /// 미리 정의된 `Pagination`을 사용하여 `Carousel`을 생성합니다.
    public init(
        currentIndex: Binding<Int>,
        pageCount: Int,
        paginationOffset: CGFloat = 20,
        @ViewBuilder content: @escaping () -> Content
    ) where P == DotsPagination {
        self._currentIndex = currentIndex
        self.pagination = DotsPagination(currentIndex: currentIndex, pageCount: pageCount)
        self.paginationOffset = paginationOffset
        self.content = content
    }
    
    public var body: some View {
        TabView(selection: $currentIndex.animation()) {
            content()
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(alignment: .bottom) {
            pagination
                .offset(y: paginationOffset)
        }
    }
}

#Preview {
    @Previewable @State var index = 0
    
    let colors: [Color] = [.red, .blue, .yellow]
    
    // 1: Default
    PaginationCarousel(currentIndex: $index, pageCount: colors.count, paginationOffset: -30) {
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
    let appearance = DotsPaginationAppearance(
        size: 10,
        spacing: 10,
        normalColor: .white,
        selectedColor: .black,
        selectedScale: 1.6
    )
    let customPagination = DotsPagination(currentIndex: $index, pageCount: colors.count, appearance: appearance)
    PaginationCarousel(pagination: customPagination) {
        ForEach(0 ..< colors.count, id: \.self) { index in
            colors[index]
                .tag(index)
        }
    }
    .frame(width: 300, height: 200)
    .padding()
}
