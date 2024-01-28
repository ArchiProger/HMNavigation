//
//  ContentChangingView.swift
//  HMNavigationDemo
//
//  Created by Archibbald on 28.01.2024.
//

import SwiftUI

struct ContentChangingView: View {
    @State var color: Color = .red
    
    var body: some View {
        VStack {
            Button("Red") {
                withAnimation {
                    color = .red
                }
            }
            .tint(.red)
            
            Button("Blue") {
                withAnimation {
                    color = .blue
                }
            }
            .tint(.blue)
            
            Button("purple") {
                withAnimation {
                    color = .purple
                }
            }
            .tint(.purple)
            
            Button("yellow") {
                withAnimation {
                    color = .yellow
                }
            }
            .tint(.yellow)
            
            Spacer()
        }
        .bottomSheet(sheetActive: .constant(true)) {
            ColorView(color: $color)
        }
        .sheetBackgroundInteraction(.medium)
        .sheetPrefersGrabberVisible(visible: true)
        .sheetDetents(detents: [.medium()])
    }
}

struct ColorView: View {
    @Binding var color: Color
    
    var body: some View {
        color.ignoresSafeArea()
    }
}

#Preview {
    ContentChangingView()
}
