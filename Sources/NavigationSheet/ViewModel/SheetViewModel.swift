//
//  File.swift
//  
//
//  Created by Archibbald on 23.01.2024.
//

import SwiftUI
import NavigationTabBar

final class SheetViewModel: ObservableObject {
    var type: SheetDisplayType = .default
    var dismissActionStatus: SheetDismissActionStatus = .enable
    var presentationPreferences: [((UISheetPresentationController?) -> Void)] = []
    
    @Published private(set) var sheetActive = false
    
    private var rootViewController: UIViewController? {
        let adapter = WindowsAdapter.shared
        
        switch type {
            case .default: return adapter.tabBar?.rootViewController
            case .navigation: return adapter.main?.rootViewController
        }
    }
    
    // MARK: - Management of the bottom sheet
    func present(@ViewBuilder content: () -> some View) {
        let controller = UIHostingController(rootView: content())
        controller.view.backgroundColor = .clear
        controller.isModalInPresentation = dismissActionStatus != .enable
        
        presentationPreferences.forEach { preference in
            preference(controller.sheetPresentationController)
        }
                        
        rootViewController?.present(controller, animated: true) {
            self.sheetActive = true
        }
    }
    
    func dismiss() {
        rootViewController?.dismiss(animated: true) {
            self.sheetActive = false
        }
    }
}
