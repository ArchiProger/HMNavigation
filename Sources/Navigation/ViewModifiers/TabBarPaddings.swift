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
    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .bottom) {
                if let controller = WindowsAdapter.shared.navigation?.rootViewController as? UIHostingController<NavigationTuple> {
                    controller.rootView
                        .opacity(0)
                }
            }
    }
}
