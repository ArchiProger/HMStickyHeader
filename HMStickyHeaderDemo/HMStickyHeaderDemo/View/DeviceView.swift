//
//  DeviceView.swift
//  HMStickyHeaderDemo
//
//  Created by Archibbald on 24.01.2024.
//  Copyright © 2024 Hummel. All rights reserved.
//

import SwiftUI

struct DeviceView: View {
    
    var device: AppleDevice
    
    var body: some View {
        HStack {
            device.systemIcon
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 70, maxHeight: 70)
            
            VStack(alignment: .center) {
                Text(device.name)
                    .font(.title3)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                
                Text(device.description)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.primary.opacity(0.5))
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 150)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .primary.opacity(0.15), radius: 10)
    }
}

#Preview("Device", traits: .sizeThatFitsLayout) {
    DeviceView(device: .iPhone)
}
