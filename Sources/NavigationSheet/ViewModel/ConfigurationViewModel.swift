//
//  File.swift
//  
//
//  Created by Archibbald on 03.02.2024.
//

import Foundation
import SwiftUI
import NavigationTabBar

final class ConfigurationViewModel: ObservableObject {
    @Published var type: SheetDisplayType = .default
    @Published var dismissActionStatus: SheetDismissActionStatus = .enable
    @Published var presentationPreferences: [((UISheetPresentationController?) -> Void)] = []
    @Published var backgroundColor: AnyShapeStyle = .init(Material.thick)
    @Published var backgroundContent: AnyView = .init(EmptyView())
    
    var rootViewController: UIViewController? {
        let adapter = WindowsAdapter.shared
        
        switch type {
            case .default: return adapter.tabBar?.rootViewController
            case .navigation: return adapter.main?.rootViewController
        }
    }
}
