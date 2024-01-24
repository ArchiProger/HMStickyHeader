//
//  StickyHeader.swift
//  La-Kendo
//
//  Created by Артур Данилов on 22.09.2023.
//

import SwiftUI

public struct StickyHeader<T: Equatable & Identifiable>: View {
    
    let ItemView: (T, Bool) -> AnyView
    
    private var background = AnyShapeStyle(Color.clear)
    
    @State private var padding: CGFloat = .zero
    @State private var offset: CGFloat = .zero
    @State private var stickyCondition: Bool = false
    
    @EnvironmentObject var viewModel: StickyViewModel<T>
    
    public init(item: @escaping (_ item: T, _ isActive: Bool) -> some View) {
        
        self.ItemView = { AnyView(item($0, $1)) }
    }
    
    public var body: some View {
        
        ScrollViewReader { proxy in
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 0) {
                    
                    ForEach(viewModel.items) { item in
                        
                        let condition = item == viewModel.currentTab
                        
                        Button {
                            viewModel.changeSelection(item, action: .press)
                        } label: {
                            ItemView(item, condition)
                                .padding(.horizontal, 8)
                                .id(item.id)
                        }
                    }
                }
            }
            .onReceive(viewModel.$currentTab) { tab in
                withAnimation {
                    proxy.scrollTo(tab?.id, anchor: .leading)
                }
            }
        }
        .padding(.top, 8)
        .background {
            Rectangle()
                .fill(background)                
                .opacity(padding <= -20 ? 1 : 0)
        }
        .offset(y: -offset)
        .offset(.named("namespace.sticky.header")) { local in
            padding = local.minY
            stickyCondition = padding <= 0
            offset = stickyCondition ? padding : .zero
        }
    }
    
    // MARK: - Stylization
    public func headerBackground<S: ShapeStyle>(_ style: S) -> Self {
        var result = self
        result.background = AnyShapeStyle(style)
        
        return result
    }
}
