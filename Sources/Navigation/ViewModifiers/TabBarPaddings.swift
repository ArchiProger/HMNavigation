//
//  File.swift
//  
//
//  Created by Archibbald on 23.01.2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    public func tabBarPaddings() -> some View {
        ModifiedContent(content: self, modifier: TabBarPaddingsViewModifier())
    }
}

fileprivate struct TabBarPaddingsViewModifier: ViewModifier {
    @Environment(\.tabBarSize) var size
    
    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .bottom) {
                Color.clear
                    .frame(width: size.width, height: size.height)
            }                 
    }
}
