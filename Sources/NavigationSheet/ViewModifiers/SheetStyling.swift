//
//  File.swift
//  
//
//  Created by Archibbald on 22.01.2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    public func sheetDisplayType(type: SheetDisplayType) -> some View {
        ModifiedContent(content: self, modifier: SheetDisplayTypeViewModifier(type: type))
    }
    
    @ViewBuilder
    public func sheetDetents(detents: [UISheetPresentationController.Detent]) -> some View {
        ModifiedContent(content: self, modifier: SheetDisplayTypeViewModifier(detents: detents))
    }
    
    @ViewBuilder
    public func sheetPrefersGrabberVisible(visible: Bool) -> some View {
        ModifiedContent(content: self, modifier: SheetDisplayTypeViewModifier(prefersGrabberVisible: visible))
    }
    
    @ViewBuilder
    public func sheetPreferredCornerRadius(radius: CGFloat) -> some View {
        ModifiedContent(content: self, modifier: SheetDisplayTypeViewModifier(preferredCornerRadius: radius))
    }
}

fileprivate struct SheetDisplayTypeViewModifier: ViewModifier {
    let sheet = SheetViewModel.shared
    
    init(type: SheetDisplayType) {
        sheet.type = type
    }
    
    init(detents: [UISheetPresentationController.Detent]) {
        sheet.presentationPreferences.append { controller in
            controller?.detents = detents
        }
    }
    
    init(prefersGrabberVisible: Bool) {
        sheet.presentationPreferences.append { controller in
            controller?.prefersGrabberVisible = prefersGrabberVisible
        }
    }
    
    init(preferredCornerRadius: CGFloat) {
        sheet.presentationPreferences.append { controller in
            controller?.preferredCornerRadius = preferredCornerRadius
        }
    }
    
    func body(content: Content) -> some View {
        content
    }
}
