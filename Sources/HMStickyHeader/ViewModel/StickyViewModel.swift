//
//  StickyViewModel.swift
//  La-Kendo
//
//  Created by Артур Данилов on 22.09.2023.
//

import Foundation
import SwiftUI
import Combine

final class StickyViewModel<T: Identifiable & Equatable>: ObservableObject {
    
    @Published private(set) var currentTab: T?
    @Published private(set) var action: TabAction? = nil
    
    let items: [T]
    let proxy: ScrollViewProxy
    
    private var cancellable: Set<AnyCancellable> = .init()
    
    enum TabAction {        
        case press
        case scroll
    }
    
    init(items: [T], proxy: ScrollViewProxy) {
        
        self.items = items
        self.currentTab = items.first
        self.proxy = proxy
        
        $currentTab
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .sink { tab in                                                
                if let tab = tab, let action = self.action, action == .press {
                    let feedback = UISelectionFeedbackGenerator()
                    feedback.selectionChanged()
                    
                    withAnimation {
                        self.action = nil
                        proxy.scrollTo(tab.id, anchor: .top)
                    }
                }
            }
            .store(in: &cancellable)
    }
    
    func changeSelection(_ tab: T, action: TabAction) {        
        withAnimation {
            self.currentTab = tab
            self.action = action
        }
    }
}
