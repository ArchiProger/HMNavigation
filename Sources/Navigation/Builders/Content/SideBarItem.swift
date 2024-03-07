//
//  SideBarItem.swift
//
//
//  Created by Archibbald on 07.03.2024.
//

import SwiftUI

public struct SideBarItem<Content: View>: NavigationContent {
    @ViewBuilder var content: () -> Content
    
    public var placement: NavigationPlacement = .sideMenu
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        content()            
    }
}
