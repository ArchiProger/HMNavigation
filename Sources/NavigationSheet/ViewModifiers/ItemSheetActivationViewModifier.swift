//
//  File.swift
//  
//
//  Created by Archibbald on 28.01.2024.
//

import SwiftUI

public struct ItemSheetActivationViewModifier<Item: Equatable, SheetContent: View>: ViewModifier {
    @Binding var item: Item?
    @ViewBuilder var content: (Item) -> SheetContent
    
    @EnvironmentObject var sheetModel: SheetViewModel
    @Environment(\.sheetController) var controller
    @Environment(\.self) var environments
    
    public func body(content: Content) -> some View {
        content
            .background {
                Color.clear
                    .onChange(of: item) { [item] newState in
                        guard item != newState else { return }
                        
                        let isRootView = controller.presentationControllersStack.isEmpty
                        let configuration = isRootView ? .init() : controller
                        
                        if let item = item, sheetModel.sheetActive {
                            sheetModel.dismiss(configuration: configuration)
                            sheetModel.present(configuration: configuration, environments: environments) { self.content(item) }
                        } else if let item = item, !sheetModel.sheetActive {
                            sheetModel.present(configuration: configuration, environments: environments) { self.content(item) }
                        } else {
                            sheetModel.dismiss(configuration: configuration)
                        }
                    }
                    .onReceive(sheetModel.$sheetActive) { active in
                        guard !active else { return }
                        
                        item = nil
                    }
            }
    }
}
