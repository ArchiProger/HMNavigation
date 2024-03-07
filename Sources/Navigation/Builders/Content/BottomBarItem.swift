//
//  BottomBarItem.swift
//
//
//  Created by Archibbald on 04.03.2024.
//

import SwiftUI

public struct BottomBarItem<Content: View>: NavigationContent {
    @ViewBuilder var content: () -> Content
    
    public var placement: NavigationPlacement = .tabBar
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        content()
    }
}
