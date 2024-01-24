//
//  OffetViewModifier.swift
//  La-Kendo
//
//  Created by Артур Данилов on 20.09.2023.
//

import Foundation
import SwiftUI

struct Offset: PreferenceKey {
    
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        
        value = nextValue()
    }
}

extension View {
    
    func offset(_ coordinateSpace: CoordinateSpace, perform: @escaping (CGRect) -> Void) -> some View {
        self
            .background {
                GeometryReader { geometry in                    
                    Color.clear
                        .preference(key: Offset.self, value: geometry.frame(in: coordinateSpace))
                        .onPreferenceChange(Offset.self, perform: perform)
                }
            }
    }
}
