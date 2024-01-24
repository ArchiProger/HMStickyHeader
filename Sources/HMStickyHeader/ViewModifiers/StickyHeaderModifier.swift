//
//  StickyHeaderModifier.swift
//  La-Kendo
//
//  Created by Артур Данилов on 20.09.2023.
//

import Foundation
import SwiftUI

extension View {
    
    func stickyHeader(_ coordinateSpace: CoordinateSpace) -> some View {
        
        self
            .modifier(StickyHeaderModifier(coordinateSpace: coordinateSpace))
    }
}

fileprivate struct StickyHeaderModifier: ViewModifier {
    
    let coordinateSpace: CoordinateSpace
    
    @State private var padding: CGFloat = .zero
    @State private var offset: CGFloat = .zero
    @State private var stickyCondition: Bool = false

    func body(content: Content) -> some View {
                        
        content
            .background {
                
                Rectangle()
                    .fill(.clear)
                    .background {
                        Color.primary.colorInvert()
                    }
                    .opacity(padding <= -20 ? 1 : 0)
            }
            .offset(y: -offset)
            .offset(coordinateSpace) { local in
                padding = local.minY
                stickyCondition = padding <= 0
                offset = stickyCondition ? padding : .zero
            }
    }
}
