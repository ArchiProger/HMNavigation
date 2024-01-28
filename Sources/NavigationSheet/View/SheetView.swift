//
//  File.swift
//  
//
//  Created by Archibbald on 27.01.2024.
//

import SwiftUI

public struct SheetView<Content: View, Modifier: ViewModifier>: View {
    var content: Content
    var modifier: Modifier
                
    @ObservedObject private var sheetModel = SheetViewModel()
    
    public var body: some View {
        content
            .modifier(modifier)
            .environmentObject(sheetModel)
    }
            
    // MARK: - Sheet modifiers
    public func sheetDisplayType(type: SheetDisplayType) -> Self {
        self.sheetModel.type = type
        
        return self
    }
    
    public func sheetDetents(detents: [UISheetPresentationController.Detent]) -> Self {
        self.sheetModel.presentationPreferences.append {
            $0?.detents = detents
        }
        
        return self
    }
        
    public func sheetPrefersGrabberVisible(visible: Bool) -> Self {
        self.sheetModel.presentationPreferences.append {
            $0?.prefersGrabberVisible = visible
        }
        
        return self
    }
        
    public func sheetPreferredCornerRadius(radius: CGFloat) -> Self {
        self.sheetModel.presentationPreferences.append {
            $0?.preferredCornerRadius = radius
        }
        
        return self
    }
    
    public func sheetBackground<S: ShapeStyle>(_ style: S) -> Self {
        self.sheetModel.backgroundColor = AnyShapeStyle(style)
        
        return self
    }
    
    public func sheetBackground<T: View>(@ViewBuilder content: () -> T) -> Self {        
        self.sheetModel.backgroundContent = AnyView(content())
        
        return self
    }
    
    public func sheetDismissAction(_ status: SheetDismissActionStatus) -> Self {
        self.sheetModel.dismissActionStatus = status
        
        return self
    }
    
    public func sheetBackgroundInteraction(_ identifier: UISheetPresentationController.Detent.Identifier?) -> Self {
        self.sheetModel.presentationPreferences.append { controller in
            controller?.largestUndimmedDetentIdentifier = identifier
        }
        
        return self
    }
}
