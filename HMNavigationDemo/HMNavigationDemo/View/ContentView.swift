//
//  ContentView.swift
//  NavigationSheetDemo
//
//  Created by Archibbald on 22.01.2024.
//

import SwiftUI
import NavigationSheet

struct ContentView: View {
    @State var sheet = false
    @State var active: Screen = .home 
                    
    var body: some View {
        TabView(selection: $active) {
            Button("Show sheet") {
                sheet = true
            }
            .tag(Screen.home)
            
            DetailView()
                .tag(Screen.detail)
        }
        .placeCustomTabBar(placement: .bottom) {
            TabBar()
        }
        .bottomSheet(sheetActive: $sheet) {
            CloseButton()
        }
        .sheetDisplayType(type: .navigation)
        .sheetDetents(detents: [.medium(), .large()])
        .sheetPreferredCornerRadius(radius: 25)
        .sheetPrefersGrabberVisible(visible: true)
        .sheetBackground(Color.clear)
        .sheetBackground {
            Color.brown
                .opacity(0.8)
                .blur(radius: 100)
        }
        .sheetDismissAction(.disable)
    }
    
    @ViewBuilder
    func TabBar() -> some View {
        HStack {
            ForEach(Screen.allCases, id: \.self) { screen in
                VStack {
                    screen.icon
                    
                    Text(screen.rawValue)
                }
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    active = screen
                }
            }
        }
        .padding(.vertical, 8)
        .background(.bar)
    }
    
    @ViewBuilder
    func DetailView() -> some View {
        ScrollView {
            VStack {
                ForEach(0...20, id: \.self) { i in
                    Text("Placeholder: \(i)")
                        .padding()
                        .background(.brown)
                        .clipShape(Capsule())
                }
            }
            .tabBarPaddings()
        }
    }
}

#Preview {
    ContentView()        
}
