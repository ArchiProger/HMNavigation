//
//  SwiftUIView.swift
//  
//
//  Created by Archibbald on 04.03.2024.
//

import SwiftUI

public struct NavigationTuple: View {    
    @State var tabBarSize: CGSize = .zero
    
    @ObservedObject var sideModel = SideBarViewModel.shared
    
    var sideMenu = AnyView(EmptyView())
    var tabBar = AnyView(EmptyView())
        
    public var body: some View {
        tabBar            
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .overlay {
                sideMenu
                    .size { size in
                        sideModel.x = -size.width
                        sideModel.width = size.width
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: sideModel.x)
                    .background(
                        Color.black.opacity(sideModel.x == 0 ? 0.7 : 0)
                            .ignoresSafeArea(.all, edges: .vertical)                
                    )
                    .gesture(sideModel.gesture)
            }
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
