//
//  AdditionTabBarViewModifier.swift
//
//
//  Created by Archibbald on 22.01.2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    public func navigationInsert(@NavigationBuilder builder: @escaping () -> NavigationTuple) -> some View {
        self
            .modifier(AdditionTabBarViewModifier(builder: builder))
    }
}

fileprivate struct AdditionTabBarViewModifier: ViewModifier {
    
    @NavigationBuilder var builder: () -> NavigationTuple
    
    @State private var tabBarSize: CGSize = .zero
    
    init(@NavigationBuilder builder: @escaping () -> NavigationTuple) {
        self.builder = builder
        
        UITabBar.appearance().isHidden = true
    }
    
    func body(content: Content) -> some View {
        content
            .environment(\.tabBarSize, tabBarSize)
            .onAppear(perform: onCreate)            
    }
    
    func onCreate() {
        let tuple = builder()
        tabBarSize = tuple.tabBarSize
    }
}
