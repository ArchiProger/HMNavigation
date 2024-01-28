//
//  File.swift
//  
//
//  Created by Archibbald on 22.01.2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    public func bottomSheet<Content: View>(
        sheetActive: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> SheetView<Self, BooleanSheetActivationViewModifier<Content>> {
        let modifier = BooleanSheetActivationViewModifier(sheetActive: sheetActive, content: content)
        
        SheetView(content: self, modifier: modifier)
    }
    
    @ViewBuilder
    public func bottomSheet<Item: Equatable, Content: View>(item: Binding<Item?>,
                                                            @ViewBuilder content: @escaping (Item) -> Content
    ) -> SheetView<Self, ItemSheetActivationViewModifier<Item, Content>> {
        let modifier = ItemSheetActivationViewModifier(item: item, content: content)
        
        SheetView(content: self, modifier: modifier)
    }
}
