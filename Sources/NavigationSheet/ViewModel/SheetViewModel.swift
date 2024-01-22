//
//  File.swift
//  
//
//  Created by Archibbald on 22.01.2024.
//

import Foundation
import SwiftUI

final class SheetViewModel: NSObject, ObservableObject {
    var type: SheetDisplayType = .default
    var presentationPreferences: [((UISheetPresentationController?) -> Void)] = []
    
    @Published private(set) var sheetActive = false
    
    // MARK: - Windows scene preferences
    private var main: UIWindow?
    private var tabBar: UIWindow?
    
    private var rootViewController: UIViewController? {
        switch type {
            case .default: return tabBar?.rootViewController
            case .navigation: return main?.rootViewController
        }
    }
    
    // MARK: - Singleton
    static let shared = SheetViewModel()
    
    private override init() {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowScene = scene as? UIWindowScene
        else { return }
        
        main = windowScene.windows.first
        tabBar = PassThroughWindow(windowScene: windowScene)
    }
    
    // MARK: - TabBar placing
    func placeTabBar(placement: Alignment = .center, @ViewBuilder content: () -> some View) {
        let controller = UIHostingController(
            rootView: content()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: placement)
        )
        controller.view.backgroundColor = .clear
        
        tabBar?.rootViewController = controller
        tabBar?.isHidden = false
    }
    
    // MARK: - Management of the bottom sheet
    func showBottomSheet(@ViewBuilder content: () -> some View) {
        let contentController = UIHostingController(rootView: content())
        contentController.sheetPresentationController?.delegate = self
        
        presentationPreferences.forEach { preference in
            preference(contentController.sheetPresentationController)
        }
                        
        rootViewController?.present(contentController, animated: true)
    }
}

extension SheetViewModel: UISheetPresentationControllerDelegate {
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        print("Что-то случилось")
    }
}


