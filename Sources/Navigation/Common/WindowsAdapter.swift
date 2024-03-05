//
//  File.swift
//  
//
//  Created by Archibbald on 22.01.2024.
//

import Foundation
import SwiftUI

public final class WindowsAdapter {
    // MARK: - Windows scene preferences
    public var main: UIWindow?
    public var navigation: UIWindow?
        
    // MARK: - Singleton
    public static let shared = WindowsAdapter()
    
    private init() {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowScene = scene as? UIWindowScene
        else { return }
        
        main = windowScene.windows.first
        navigation = PassThroughWindow(windowScene: windowScene)
        navigation?.rootViewController = navigationController
        navigation?.isHidden = false
    }
    
    private var navigationController: UIHostingController<NavigationTuple> {
        let controller = UIHostingController(rootView: NavigationTuple())
        controller.view.backgroundColor = .clear
        
        return controller
    }
}
