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
            .modifier(NavigationInsertViewModifier(builder: builder))
    }
}

fileprivate struct NavigationInsertViewModifier: ViewModifier {
    
    @NavigationBuilder var builder: () -> NavigationTuple
    
    @ObservedObject var sideModel = SideBarViewModel.shared
    
    init(@NavigationBuilder builder: @escaping () -> NavigationTuple) {
        self.builder = builder
        
        UITabBar.appearance().isHidden = true
    }
    
    func body(content: Content) -> some View {
        content            
            .environment(\.sideMenuStatus, sideModel.isActive ? .active : .inactive)
            .onAppear(perform: onCreate)
            .gesture(sideModel.gesture)
    }
    
    func onCreate() {
        builder()
    }
}
