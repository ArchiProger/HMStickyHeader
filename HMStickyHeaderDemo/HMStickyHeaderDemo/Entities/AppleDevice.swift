//
//  Device.swift
//  HMStickyHeaderDemo
//
//  Created by Archibbald on 24.01.2024.
//  Copyright © 2024 Hummel. All rights reserved.
//

import Foundation
import SwiftUI

struct DeviceCategory: Identifiable, Equatable {
    let id = UUID()
    
    let title: String
    let devices: [AppleDevice]
}

struct AppleDevice: Identifiable, Equatable {
    let id = UUID()
    
    let name: String
    let description: String
    let systemIcon: Image
    let category: String
}

extension [DeviceCategory] {
    static let preview: Self = {
        // Примерные данные
        let devices = [
            AppleDevice(name: "MacBook Pro", description: "Powerful laptop for professionals", systemIcon: Image(systemName: "laptopcomputer"), category: "Laptops"),
            AppleDevice(name: "iPhone 12", description: "Latest smartphone from Apple", systemIcon: Image(systemName: "iphone"), category: "Phones"),
            AppleDevice(name: "iPad Pro", description: "Powerful tablet with Pro features", systemIcon: Image(systemName: "ipad"), category: "Tablets"),
            AppleDevice(name: "iMac", description: "Stylish all-in-one desktop computer", systemIcon: Image(systemName: "laptopcomputer.and.iphone"), category: "Desktops"),
            AppleDevice(name: "Mac Pro", description: "High-performance workstation computer", systemIcon: Image(systemName: "macpro.gen3"), category: "Workstations"),
            AppleDevice(name: "Apple Watch", description: "Smartwatch for fitness and communication", systemIcon: Image(systemName: "applewatch"), category: "Wearables"),
            AppleDevice(name: "AirPods", description: "Wireless earbuds with active noise cancellation", systemIcon: Image(systemName: "airpods"), category: "Audio Accessories"),
            AppleDevice(name: "HomePod", description: "Smart speaker with high-fidelity audio", systemIcon: Image(systemName: "hifispeaker"), category: "Audio Accessories"),
            AppleDevice(name: "Mac Mini", description: "Compact desktop computer", systemIcon: Image(systemName: "macmini"), category: "Desktops"),
            AppleDevice(name: "Apple TV", description: "Digital media player and entertainment hub", systemIcon: Image(systemName: "appletv"), category: "Entertainment Devices"),
            AppleDevice(name: "Magic Keyboard", description: "Wireless rechargeable keyboard", systemIcon: Image(systemName: "keyboard"), category: "Accessories"),
            AppleDevice(name: "Magic Mouse", description: "Wireless multi-touch mouse", systemIcon: Image(systemName: "magicmouse"), category: "Accessories")
        ]

        
        // Разбиение данных по категориям
        return Dictionary(grouping: devices, by: { $0.category })
            .map { DeviceCategory(title: $0, devices: $1) }
    }()
}

extension AppleDevice {
    static let iPhone = AppleDevice(name: "iPhone 12", description: "Latest smartphone from Apple", systemIcon: Image(systemName: "iphone"), category: "Phones")
}

