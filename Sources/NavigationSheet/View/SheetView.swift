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
                
    @StateObject private var sheetModel = SheetViewModel()
    @ObservedObject private var configModel = ConfigurationViewModel()
    
    public var body: some View {
        content
            .modifier(modifier)
            .environmentObject(sheetModel)
            .environmentObject(configModel)
    }
            
    // MARK: - Sheet modifiers
    
    /// Specifies the display style of the modal window. On top of navigation or by default
    /// - Parameter type: Modal window style
    public func sheetDisplayType(type: SheetDisplayType) -> Self {
        self.configModel.type = type
        
        return self
    }
    
    /// Allowable height of the modal window
    /// - Parameter detents: Array of permissible heights
    public func sheetDetents(detents: [UISheetPresentationController.Detent]) -> Self {
        self.configModel.presentationPreferences.append {
            $0?.detents = detents
        }
        
        return self
    }
    
    /// Turning on/off the drag indicator
    /// - Parameter visible: Drag indicator display
    public func sheetPrefersGrabberVisible(visible: Bool) -> Self {
        self.configModel.presentationPreferences.append {
            $0?.prefersGrabberVisible = visible
        }
        
        return self
    }
    
    /// Round the corners of the modal window
    /// - Parameter radius: Radius of rounding
    public func sheetPreferredCornerRadius(radius: CGFloat) -> Self {
        self.configModel.presentationPreferences.append {
            $0?.preferredCornerRadius = radius
        }
        
        return self
    }
        
    /// Background style of the modal window
    /// - Parameter style: Background style
    public func sheetBackground<S: ShapeStyle>(_ style: S) -> Self {
        self.configModel.backgroundColor = AnyShapeStyle(style)
        
        return self
    }
    
    /// Background View
    /// - Parameter content: background View
    public func sheetBackground<T: View>(@ViewBuilder content: () -> T) -> Self {
        self.configModel.backgroundContent = AnyView(content())
        
        return self
    }
    
    /// Enable/disable hiding the modal window with a gesture
    /// - Parameter status: Gesture status
    public func sheetDismissAction(_ status: SheetDismissActionStatus) -> Self {
        self.configModel.dismissActionStatus = status
        
        return self
    }
    
    /// The largest detent that doesn’t dim the view underneath the sheet.
    /// The default value is nil, which means the system adds a noninteractive dimming view underneath the sheet at all detents. Set this property to only add the dimming view at detents larger than the detent you specify. For example, set this property to medium to add the dimming view at the large detent.
    /// Without a dimming view, the undimmed area around the sheet responds to user interaction, allowing for a nonmodal experience. You can use this behavior for sheets with interactive content underneath them.
    public func sheetBackgroundInteraction(_ identifier: UISheetPresentationController.Detent.Identifier?) -> Self {
        self.configModel.presentationPreferences.append { controller in
            controller?.largestUndimmedDetentIdentifier = identifier
        }
        
        return self
    }
}
