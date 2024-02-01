//
//  File.swift
//  
//
//  Created by Archibbald on 23.01.2024.
//

import SwiftUI
import NavigationTabBar

final class SheetViewModel: NSObject, UISheetPresentationControllerDelegate, ObservableObject {
    var type: SheetDisplayType = .default
    var dismissActionStatus: SheetDismissActionStatus = .enable
    var presentationPreferences: [((UISheetPresentationController?) -> Void)] = []
    var backgroundColor: AnyShapeStyle = .init(Material.thick)
    var backgroundContent: AnyView = .init(EmptyView())
    
    @Published private(set) var sheetActive = false            
    
    private var rootViewController: UIViewController? {
        let adapter = WindowsAdapter.shared
        
        switch type {
            case .default: return adapter.tabBar?.rootViewController
            case .navigation: return adapter.main?.rootViewController
        }
    }
    
    // MARK: - Management of the bottom sheet
    func present(configuration: SheetControllersViewModel, environments: EnvironmentValues, @ViewBuilder content: () -> some View) {
        let controller = UIHostingController(
            rootView: content()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(backgroundColor)
                .background(backgroundContent)
                .environment(\.sheetDismiss, { self.dismiss(configuration: configuration) })
                .environment(\.sheetController, configuration)
                .environment(\.self, environments)
        )
        controller.view.backgroundColor = .clear
        controller.isModalInPresentation = dismissActionStatus != .enable
        controller.sheetPresentationController?.delegate = self          
        
        presentationPreferences.forEach { preference in
            preference(controller.sheetPresentationController)
        }
        
        let root = configuration.presentationControllersStack.last ?? rootViewController
                        
        root?.present(controller, animated: true) {
            configuration.presentationControllersStack.append(controller)
            self.sheetActive = true
        }
    }
    
    func dismiss(configuration: SheetControllersViewModel, shouldChangeNavigationStack: Bool = true) {
        let root = configuration.presentationControllersStack.last ?? rootViewController
        
        root?.dismiss(animated: true) {
            guard shouldChangeNavigationStack else { return }
            
            self.sheetActive = false
            
            if !configuration.presentationControllersStack.isEmpty {
                configuration.presentationControllersStack.removeLast()
            }
        }
    }
    
    // MARK: - Bottom sheet delegate methods
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        sheetActive = false
    }
}
