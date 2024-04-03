//
//  File.swift
//  
//
//  Created by Archibbald on 23.01.2024.
//

import SwiftUI
import Navigation

final class SheetViewModel: NSObject, UISheetPresentationControllerDelegate, ObservableObject {
    @Published var sheetActive = false
    @Published var controller: UIViewController? = nil
    @Published var hostingController: UISheetHostingController<AnyView>?
    @Published var configuration = ConfigurationViewModel()
    @Published var environments = EnvironmentValues()
    
    // MARK: - Management of the bottom sheet
    func present(@ViewBuilder content: @escaping () -> some View) {
        hostingController = UISheetHostingController(
            rootView: prepare(content: content)
        )
        hostingController?.environments = environments
        hostingController?.shadow = configuration.shadow == .default ? nil : configuration.shadow
        hostingController?.view.backgroundColor = .clear
        hostingController?.isModalInPresentation = configuration.dismissActionStatus != .enable
        hostingController?.sheetPresentationController?.delegate = self
        
        if let hostingController {
            configuration.presentationPreferences.forEach { preference in
                preference(hostingController.sheetPresentationController)
            }
                    
            self.controller?.present(hostingController, animated: true) {
                self.sheetActive = true
            }
        }
    }
    
    func dismiss(shouldChangeNavigationStack: Bool = true) {
        controller?.dismiss(animated: true) {
            guard shouldChangeNavigationStack else { return }
            
            self.sheetActive = false
        }
    }
    
    func prepare(@ViewBuilder content: @escaping () -> some View) -> AnyView {
        .init(
            content()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(self.configuration.backgroundColor)
                .background(self.configuration.backgroundContent)
                .environment(\.sheetDismiss, { self.dismiss() })
        )
    }
    
    // MARK: - Bottom sheet delegate methods
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        sheetActive = false
    }
}
