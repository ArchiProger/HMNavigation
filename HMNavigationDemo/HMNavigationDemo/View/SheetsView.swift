//
//  SheetsView.swift
//  HMNavigationDemo
//
//  Created by Archibbald on 28.01.2024.
//

import SwiftUI

struct SheetsView: View {
    
    @State var sheet: SheetTab? = .green
    
    enum SheetTab: String, CaseIterable {
        case blue, green, purple, brown
        
        var color: Color {
            switch self {
                case .blue: return .blue
                case .green: return .green
                case .purple: return .purple
                case .brown: return .brown
            }
        }
    }
    
    var body: some View {
        VStack {
            Button("Close all") {
                sheet = nil
            }
            .tint(.orange)
            
            ForEach(SheetTab.allCases, id: \.self) { sheet in
                Button("Show \(sheet.rawValue)") {
                    self.sheet = sheet
                }
                .tint(sheet.color)
            }
            
            Spacer()
        }
        .bottomSheet(item: $sheet) { sheet in
            sheet.color.ignoresSafeArea()
        }
        .sheetBackgroundInteraction(.medium)
        .sheetDetents(detents: [.medium()])
        .sheetPrefersGrabberVisible(visible: true)
        .sheetShadow(color: Color.orange, radius: 20)
    }
}

#Preview {
    SheetsView()
}
