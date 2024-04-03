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
    @EnvironmentObject var configModel: ConfigurationViewModel
    
    @Environment(\.hostingController) var controller
    @Environment(\.self) var environments
    
    public func body(content: Content) -> some View {
        let _ = update()
        
        content
            .background {
                Color.clear
                    .onAppear(perform: onCreate)
                    .onChange(of: item) { [item] newState in
                        guard item != newState else { return }
                        
                        sheetModel.controller = controller ?? configModel.rootViewController
                        sheetModel.configuration = configModel
                        sheetModel.environments = environments
                        
                        if let item = newState {
                            if sheetModel.sheetActive {
                                sheetModel.dismiss(shouldChangeNavigationStack: false)
                            }
                            sheetModel.present {
                                self.content(item)                                    
                            }
                        } else {
                            sheetModel.dismiss()
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
    private func onCreate() {
        guard let item = item else { return }
        
        sheetModel.controller = controller ?? configModel.rootViewController
        sheetModel.configuration = configModel
        sheetModel.environments = environments
        sheetModel.present {
            content(item)
        }
    }
    
    private func update() {
        if let item {
            sheetModel.hostingController?.rootView = sheetModel.prepare {
                self.content(item)
            }
        }
    }
}
