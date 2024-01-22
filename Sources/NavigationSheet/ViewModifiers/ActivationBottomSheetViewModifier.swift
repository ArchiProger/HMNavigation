//
//  File.swift
//  
//
//  Created by Archibbald on 22.01.2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    public func bottomSheet(sheetActive: Binding<Bool>, @ViewBuilder content: @escaping () -> some View) -> some View {
        ModifiedContent(content: self, modifier: ActivationBottomSheetViewModifier(sheetActive: sheetActive, content: content))
    }
}

fileprivate struct ActivationBottomSheetViewModifier<SheetContent: View>: ViewModifier {
    
    @Binding var sheetActive: Bool
    
    @ViewBuilder var content: () -> SheetContent
    
    @EnvironmentObject var sheet: SheetViewModel
    
    @Environment(\.self) var environments
    
    func body(content: Content) -> some View {
        content
            .onChange(of: sheetActive) { active in
                guard active != sheet.sheetActive else { return }
                
                if active {
                    sheet.showBottomSheet {
                        self.content()
                            .environment(\.self, environments)
                    }
                } else {
                    
                }
            }
    }
}
