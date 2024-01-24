//
//  ContentView.swift
//  HMStickyHeaderDemo
//
//  Created by Archibbald on 24.01.2024.
//

import SwiftUI
import HMStickyHeader

struct ContentView: View {
    var categories: [DeviceCategory] = .preview
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    CategoriesView()
                }
                .padding()
                .safeAreaInset(edge: .top) {
                    StickyHeader<DeviceCategory> { item, isActive in
                        VStack(spacing: 3) {
                            Text(item.title)
                            
                            Capsule()
                                .frame(height: 3)
                                .opacity(isActive ? 1 : 0)
                        }
                        .foregroundStyle(isActive ? Color.primary : Color.gray)
                    }
                    .headerBackground(.regularMaterial)
                }
            }
            .sticky(items: categories)
            .navigationTitle("Auto-scrollable")
            .background(
                LinearGradient(
                    colors: [
                        .clear,
                        .gray
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
        }
    }
    
    @ViewBuilder
    private func CategoriesView() -> some View {
        ForEach(categories) { category in
            Section {
                ForEach(category.devices) { device in
                    DeviceView(device: device)
                }
            } header: {
                Text(category.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .stickyItem(category)
            }
        }
    }
}

#Preview {
    ContentView()
}
