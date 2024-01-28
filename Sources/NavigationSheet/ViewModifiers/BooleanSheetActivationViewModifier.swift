//
//  File.swift
//  
//
//  Created by Archibbald on 27.01.2024.
//

import SwiftUI

public struct BooleanSheetActivationViewModifier<SheetContent: View>: ViewModifier {
    
    @Binding var sheetActive: Bool
    @ViewBuilder var content: () -> SheetContent
    
    @EnvironmentObject var sheetModel: SheetViewModel
    @Environment(\.sheetController) var controller
    @Environment(\.self) var environments
    
    public func body(content: Content) -> some View {
        content
            .background {
                Color.clear
                    .onChange(of: sheetActive) { active in
                        guard active != sheetModel.sheetActive else { return }
                        
                        let isRootView = controller.presentationControllersStack.isEmpty
                        let configuration = isRootView ? .init() : controller
                        
                        if active {
                            sheetModel.present(configuration: configuration, environments: environments, content: self.content)
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
}
