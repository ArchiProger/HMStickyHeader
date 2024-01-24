//
//  StickyScrollView.swift
//  La-Kendo
//
//  Created by Артур Данилов on 22.09.2023.
//

import SwiftUI

extension ScrollView {
    @ViewBuilder
    public func sticky<T: Identifiable & Equatable>(items: [T]) -> some View {
        ScrollViewReader { proxy in
            self
                .environmentObject(StickyViewModel(items: items, proxy: proxy))
                .coordinateSpace(name: "namespace.sticky.header")
        }
    }
}
