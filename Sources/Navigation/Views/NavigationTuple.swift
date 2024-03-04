//
//  SwiftUIView.swift
//  
//
//  Created by Archibbald on 04.03.2024.
//

import SwiftUI

public struct NavigationTuple: View {    
    @State var tabBarSize: CGSize = .zero
    @State private var x = -UIScreen.main.bounds.width + 65
    
    private var sideMenu = AnyView(EmptyView())
    private var tabBar = AnyView(EmptyView())
    private var width = UIScreen.main.bounds.width - 65
        
    public var body: some View {
        tabBar
            .size { size in
                tabBarSize = size
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)            
            .overlay{
                sideMenu
                    .offset(x: x)
                    .background(
                        Color.black.opacity(x == 0 ? 0.7 : 0)
                            .ignoresSafeArea(.all, edges: .vertical)
                    )
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation{
                            if value.translation.width > 0 {
                                x = -width + value.translation.width
                            }else{
                                x = value.translation.width
                            }
                        }
                    }
                    .onEnded { value in
                        withAnimation{
                            if -x < width/2 {
                                x = 0
                            }else{
                                x = -width
                            }
                        }
                    }
            )
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
