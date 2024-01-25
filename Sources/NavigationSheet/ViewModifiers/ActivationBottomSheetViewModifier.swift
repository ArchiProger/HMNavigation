//
//  File.swift
//  
//
//  Created by Archibbald on 22.01.2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    public func bottomSheet<Content: View>(sheetActive: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> SheetView<Self, Content> {
        SheetView(sheetActive: sheetActive, content: self, sheetContent: content)
    }
}

public struct SheetView<Content: View, SheetContent: View>: View {
    @Binding var sheetActive: Bool
    
    var content: Content
    @ViewBuilder var sheetContent: () -> SheetContent
    
    var backgroundColor: AnyShapeStyle = .init(Material.thick)
    var backgroundContent: AnyView = .init(EmptyView())
    
    @ObservedObject private var sheetModel = SheetViewModel()
    
    @Environment(\.sheetController) var controller
    @Environment(\.self) var environments
    
    public var body: some View {
        content
            .background {
                Color.clear
                    .onChange(of: sheetActive) { active in
                        guard active != sheetModel.sheetActive else { return }
                        
                        let isRootView = controller.presentationControllersStack.isEmpty
                        let configuration = isRootView ? .init() : controller
                        
                        if active {
                            sheetModel.present(configuration: configuration) {
                                sheetContent()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(backgroundColor)
                                    .background(backgroundContent)
                                    .environment(\.sheetDismiss, { sheetModel.dismiss(configuration: configuration) })
                                    .environment(\.sheetController, configuration)
                                    .environment(\.self, environments)
                            }
                        } else {
                            sheetModel.dismiss(configuration: configuration)
                        }
                    }
                    .onReceive(sheetModel.$sheetActive) { active in
                        guard active != sheetActive else { return }
                        
                        sheetActive = active
                    }
            }
    }
    
    // MARK: - Sheet stylization
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
        var result = self
        result.backgroundColor = AnyShapeStyle(style)
        
        return result
    }
    
    public func sheetBackground<Content: View>(@ViewBuilder content: () -> Content) -> Self {
        var result = self
        result.backgroundContent = AnyView(content())
        
        return result
    }
    
    public func sheetDismissAction(_ status: SheetDismissActionStatus) -> Self {
        self.sheetModel.dismissActionStatus = status
        
        return self
    }
}
