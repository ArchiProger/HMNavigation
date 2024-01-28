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
    @State var active: Screen = .tree
    
    var body: some View {
        TabView(selection: $active) {
            SheetsTreeView()
                .tag(Screen.tree)
            
            SheetsView()
                .tag(Screen.sheets)
            
            ContentChangingView()
                .tag(Screen.content)
            
            DetailView()
                .tag(Screen.detail)
        }
        .placeCustomTabBar(placement: .bottom) {
            TabBar()
        }
    }
    
    @ViewBuilder
    func TabBar() -> some View {
        HStack {
            ForEach(Screen.allCases, id: \.self) { screen in
                VStack {
                    screen.icon
                    
                    Text(screen.rawValue)
                        .font(.footnote)
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
