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
                    .onAppear(perform: onCreate)
                    .onChange(of: item) { [item] newState in
                        guard item != newState else { return }
                        
                        if let item = newState, sheetModel.sheetActive {
                            sheetModel.dismiss(configuration: configuration, shouldChangeNavigationStack: false)
                            sheetModel.present(configuration: configuration, environments: environments) { self.content(item) }
                        } else if let item = newState, !sheetModel.sheetActive {
                            sheetModel.present(configuration: configuration, environments: environments) { self.content(item) }
                        } else {
                            sheetModel.dismiss(configuration: configuration)
                        }
                    }
                    .onReceive(
                        sheetModel.$sheetActive
                            .dropFirst()
                            .receive(on: RunLoop.main)
                            .removeDuplicates()
                    ) { active in
                        guard !active else { return }
                        
                        item = nil
                    }
            }
    }
    
    // MARK: - Sheet settings
    private var isRootView: Bool {
        controller.presentationControllersStack.isEmpty
    }
    
    private var configuration: SheetControllersViewModel {
        isRootView ? .init() : controller
    }
    
    private func onCreate() {
        guard let item = item else { return }
        
        sheetModel.present(configuration: configuration, environments: environments) {
            content(item)
        }
    }
}
