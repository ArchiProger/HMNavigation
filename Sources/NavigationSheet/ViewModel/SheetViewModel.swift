//
//  File.swift
//  
//
//  Created by Archibbald on 23.01.2024.
//

import SwiftUI
import NavigationTabBar

final class SheetViewModel: NSObject, UISheetPresentationControllerDelegate, ObservableObject {
    @Published var sheetActive = false
    @Published var controller: UIViewController? = nil
    @Published var configuration = ConfigurationViewModel()
    @Published var environments = EnvironmentValues()
    
    // MARK: - Management of the bottom sheet
    func present(@ViewBuilder content: @escaping () -> some View) {
        let controller = UISheetHostingController(
            rootView: content()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(self.configuration.backgroundColor)
                .background(self.configuration.backgroundContent)
                .environment(\.sheetDismiss, { self.dismiss() })                
        )
        controller.environments = environments
        controller.shadow = configuration.shadow == .default ? nil : configuration.shadow
        controller.view.backgroundColor = .clear
        controller.isModalInPresentation = configuration.dismissActionStatus != .enable
        controller.sheetPresentationController?.delegate = self
        
        configuration.presentationPreferences.forEach { preference in
            preference(controller.sheetPresentationController)
        }
                
        self.controller?.present(controller, animated: true) {
            self.sheetActive = true
        }
    }
    
    func dismiss(shouldChangeNavigationStack: Bool = true) {
        controller?.dismiss(animated: true) {
            guard shouldChangeNavigationStack else { return }
            
            self.sheetActive = false
        }
    }
    
    // MARK: - Bottom sheet delegate methods
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        sheetActive = false
    }
}
