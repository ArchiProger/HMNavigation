//
//  File.swift
//  
//
//  Created by Archibbald on 03.02.2024.
//

import Foundation
import SwiftUI
import NavigationTabBar

struct UIShadow: Equatable {
    var color: CGColor?
    var radius: CGFloat
    var offset: CGSize
    var path: CGPath?
    
    static let `default`: Self = .init(color: nil,
                                       radius: 1,
                                       offset: .init(width: 0, height: -3),
                                       path: nil
    )
}

final class ConfigurationViewModel: ObservableObject {
    @Published var type: SheetDisplayType = .default
    @Published var dismissActionStatus: SheetDismissActionStatus = .enable
    @Published var presentationPreferences: [((UISheetPresentationController?) -> Void)] = []
    @Published var backgroundColor: AnyShapeStyle = .init(Material.thick)
    @Published var backgroundContent: AnyView = .init(EmptyView())
    @Published var shadow: UIShadow = .default
    
    var rootViewController: UIViewController? {
        let adapter = WindowsAdapter.shared
        
        switch type {
            case .default: return adapter.tabBar?.rootViewController
            case .navigation: return adapter.main?.rootViewController
        }
    }
}
