//
//  TabBarPaddingsViewModifier.swift
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
    @StateObject private var navigationModel = NavigationViewModel.shared
    
    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .bottom) {
                Color.clear
                    .frame(height: navigationModel.tabBarSize.height)
            }
    }
}
