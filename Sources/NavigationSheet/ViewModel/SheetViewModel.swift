//
//  File.swift
//  
//
//  Created by Archibbald on 23.01.2024.
//

import SwiftUI
import NavigationTabBar

struct ColorSchemeToggle: ViewModifier {
    
    @Environment(\.colorScheme) var scheme
    
    func body(content: Content) -> some View {
        content
            .onChange(of: scheme) { _ in
                print(scheme)
            }
    }
}

final class SheetViewModel: NSObject, UISheetPresentationControllerDelegate, ObservableObject {
    @Published var sheetActive = false
    
    // MARK: - Management of the bottom sheet
    func present(stack: SheetControllersViewModel,
                 configuration: ConfigurationViewModel,                 
                 @ViewBuilder content: () -> some View
    ) {
        let controller = UISheetHostingController(            
            rootView: content()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(configuration.backgroundColor)
                .background(configuration.backgroundContent)
                .environment(\.sheetDismiss, { self.dismiss(stack: stack, configuration: configuration) })
                .environment(\.sheetController, stack)                          
        )
        controller.shadow = configuration.shadow == .default ? nil : configuration.shadow
        controller.view.backgroundColor = .clear
        controller.isModalInPresentation = configuration.dismissActionStatus != .enable
        controller.sheetPresentationController?.delegate = self
        
        configuration.presentationPreferences.forEach { preference in
            preference(controller.sheetPresentationController)
        }
        
        let root = stack.presentationControllersStack.last ?? configuration.rootViewController
                        
        root?.present(controller, animated: true) {
            stack.presentationControllersStack.append(controller)
            self.sheetActive = true
        }
    }
    
    func dismiss(stack: SheetControllersViewModel,
                 configuration: ConfigurationViewModel,
                 shouldChangeNavigationStack: Bool = true
    ) {
        let root = stack.presentationControllersStack.last ?? configuration.rootViewController
        
        root?.dismiss(animated: true) {
            guard shouldChangeNavigationStack else { return }
            
            self.sheetActive = false
            
            if !stack.presentationControllersStack.isEmpty {
                stack.presentationControllersStack.removeLast()
            }
        }
    }
    
    // MARK: - Bottom sheet delegate methods
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        sheetActive = false
    }
}
