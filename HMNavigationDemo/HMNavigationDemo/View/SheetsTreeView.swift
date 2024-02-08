//
//  SheetsView.swift
//  HMNavigationDemo
//
//  Created by Archibbald on 25.01.2024.
//

import SwiftUI
import NavigationSheet

struct SheetsTreeView: View {
    @State var blueSheetActive = false
    @State var redSheetActive = false
    @State var pinkSheetActive = false
    
    var body: some View {
        VStack {
            Button("Show blue sheet") {
                blueSheetActive.toggle()
            }
        }
        .bottomSheet(sheetActive: $blueSheetActive) {
            Button("Show red sheet") {
                redSheetActive.toggle()
            }
            .tint(Color.primary)
            .bottomSheet(sheetActive: $redSheetActive) {
                Button("Show pink sheet") {
                    pinkSheetActive.toggle()
                }
                .bottomSheet(sheetActive: $pinkSheetActive) {
                    CloseButton()
                }
                .sheetBackground(Color.pink)
                .sheetDismissAction(.disable)
            }
            .sheetBackground(Color.red)
            .sheetDetents(detents: [.medium()])
        }
        .sheetBackground(.regularMaterial)
    }
}

#Preview {
    SheetsTreeView()
}
