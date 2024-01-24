//
//  StickyItemMofifier.swift
//  La-Kendo
//
//  Created by Артур Данилов on 22.09.2023.
//

import Foundation
import SwiftUI

extension View {
    
    @ViewBuilder
    public func stickyItem<T: Identifiable & Equatable>(_ item: T) -> some View {
        
        self
            .modifier(StickyItemModifier(item: item))
    }
}

fileprivate struct StickyItemModifier<T: Identifiable & Equatable>: ViewModifier {
    
    let item: T
    
    @EnvironmentObject var viewModel: StickyViewModel<T>
    
    func body(content: Content) -> some View {
        
        content
            .id(item.id)
            .offset(.named("namespace.sticky.header")) { rect in
                
                let minY = rect.minY                                
                
                if (0...rect.size.height).contains(-minY) && viewModel.currentTab != item {
                    
                    viewModel.changeSelection(item, action: .scroll)
                }
            }
    }
}
