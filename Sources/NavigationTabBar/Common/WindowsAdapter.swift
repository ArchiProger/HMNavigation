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
    public var tabBar: UIWindow?
        
    // MARK: - Singleton
    public static let shared = WindowsAdapter()
    
    private init() {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowScene = scene as? UIWindowScene
        else { return }
                        
        main = windowScene.windows.first
        tabBar = PassThroughWindow(windowScene: windowScene)
        tabBar?.rootViewController = UIViewController()
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
}


