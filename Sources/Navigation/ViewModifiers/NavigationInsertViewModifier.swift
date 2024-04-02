//
//  AdditionTabBarViewModifier.swift
//
//
//  Created by Archibbald on 22.01.2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    public func navigationInsert(defaultTabBarDisabled: Bool = true, @NavigationBuilder builder: @escaping () -> NavigationTuple) -> some View {
        self
            .modifier(NavigationInsertViewModifier(defaultTabBarDisabled: defaultTabBarDisabled, builder: builder))
    }
    
    @ViewBuilder
    public func navigationGesture(_ enable: Bool = true) -> some View {
        self
            .onAppear {
                NavigationViewModel.shared.isGesture = enable
            }
            .onDisappear {
                NavigationViewModel.shared.isGesture = !enable
            }
    }
}

fileprivate struct NavigationInsertViewModifier: ViewModifier {
    
    @NavigationBuilder var builder: () -> NavigationTuple
    
    @ObservedObject var navigationModel = NavigationViewModel.shared
    
    @Environment(\.self) var environments
    
    init(defaultTabBarDisabled: Bool, @NavigationBuilder builder: @escaping () -> NavigationTuple) {
        self.builder = builder
        
        UITabBar.appearance().isHidden = defaultTabBarDisabled
    }
    
    func body(content: Content) -> some View {
        content          
            .environment(\.tabBarSize, navigationModel.tabBarSize)
            .environment(\.sideMenuStatus, navigationModel.isActive ? .active : .inactive)
            .onAppear(perform: onCreate)
            .gesture(navigationModel.gesture)
    }
    
    func onCreate() {
        guard
            let root =  WindowsAdapter.shared.navigation?.rootViewController,
            let controller = root as? UIHostingController<AnyView>
        else { return }
        
        let tuple = builder()
        let view = tuple
            .environment(\.self, environments)
        
        controller.rootView = .init(view)
    }
}
