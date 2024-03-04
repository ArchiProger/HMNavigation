//
//  NavigationMenu.swift
//
//
//  Created by Archibbald on 04.03.2024.
//

import SwiftUI

public struct NavigationMenu<Content: View>: NavigationContent {
    public var placement: NavigationPlacement
    @ViewBuilder var content: () -> Content
    
    public init(placement: NavigationPlacement, @ViewBuilder content: @escaping () -> Content) {
        self.placement = placement
        self.content = content
    }
    
    public var body: some View {
        content()
    }
}
