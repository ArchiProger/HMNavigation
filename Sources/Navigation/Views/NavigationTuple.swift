//
//  SwiftUIView.swift
//  
//
//  Created by Archibbald on 04.03.2024.
//

import SwiftUI

public struct NavigationTuple: View {            
    @StateObject var navigationModel = NavigationViewModel.shared
    
    var sideMenu = AnyView(EmptyView())
    var tabBar = AnyView(EmptyView())
        
    public var body: some View {
        tabBar   
            .size { size in
                navigationModel.tabBarSize = size
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .overlay {
                sideMenu
                    .size { size in
                        navigationModel.x = -size.width
                        navigationModel.width = size.width
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: navigationModel.x)
                    .background(
                        Color.black.opacity(navigationModel.x == 0 ? 0.7 : 0)
                            .ignoresSafeArea(.all, edges: .vertical)
                            .onTapGesture {
                                navigationModel.isActive = false
                            }
                    )
                    .disabled(navigationModel.direction != nil)
                    .gesture(navigationModel.gesture)                    
            }
            .environment(\.sideMenuStatus, navigationModel.isActive ? .active : .inactive)
            .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    func placeSideMenu<Content: View>(@ViewBuilder content: () -> Content) -> Self {
        var view = self
        view.sideMenu = .init(content())
        
        return view
    }
    
    func placeBottomBar<Content: View>(@ViewBuilder content: () -> Content) -> Self {
        var view = self
        view.tabBar = .init(content())
        
        return view
    }
}

#Preview {
    NavigationTuple()
}
