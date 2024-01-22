//
//  AdditionTabBarViewModifier.swift
//
//
//  Created by Archibbald on 22.01.2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    public func placeCustomTabBar(placement: Alignment = .center, @ViewBuilder content: @escaping () -> some View) -> some View {
        self
            .modifier(AdditionTabBarViewModifier(placement: placement, content: content))
    }
}

fileprivate struct AdditionTabBarViewModifier<TabBarContent: View>: ViewModifier {
    
    let placement: Alignment
    let content: () -> TabBarContent
    
    @EnvironmentObject var sheet: SheetViewModel        
    
    init(placement: Alignment, @ViewBuilder content: @escaping () -> TabBarContent) {
        self.placement = placement
        self.content = content
        
        UITabBar.appearance().isHidden = true
    }
    
    func body(content: Content) -> some View {
        content
            .onAppear(perform: onCreate)            
    }
    
    func onCreate() {
        sheet.placeTabBar(placement: placement, content: content)
    }
}
