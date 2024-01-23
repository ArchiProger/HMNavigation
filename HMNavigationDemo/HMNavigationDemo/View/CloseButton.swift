//
//  CloseButton.swift
//  HMNavigationDemo
//
//  Created by Archibbald on 23.01.2024.
//

import SwiftUI

struct CloseButton: View {
    
    @Environment(\.sheetDismiss) var dismiss
    
    var body: some View {
        Button(action: dismiss) {
            Image(systemName: "xmark")
                .font(.title2.weight(.bold))
                .foregroundStyle(.gray)
                .padding(8)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        }
    }
}

@available(iOS 17, *)
#Preview("Close button", traits: .sizeThatFitsLayout) {
    CloseButton()
}
