//
//  NavigationBuilder.swift
//
//
//  Created by Archibbald on 04.03.2024.
//

import Foundation
import SwiftUI

@resultBuilder
public struct NavigationBuilder {
    public static func buildBlock(_ components: (any NavigationContent)...) -> NavigationTuple {
        guard
            let root =  WindowsAdapter.shared.navigation?.rootViewController,
            let controller = root as? UIHostingController<NavigationTuple>
        else { return .init() }
        
        for component in components {
            let view = controller.rootView
            
            controller.rootView = switch component.placement {
                case .tabBar:
                     view.placeBottomBar { AnyView(component.body) }
                case .sideMenu:
                    view.placeSideMenu { AnyView(component.body) }
            }
        }                
                
        return controller.rootView
    }
    
    public static func buildEither(first component: any NavigationContent) -> NavigationTuple {
        return buildBlock(component)
    }        
    
    public static func buildEither(second component: any NavigationContent) -> NavigationTuple {
        return buildBlock(component)
    }
    
    public static func buildArray(_ components: [any NavigationContent]) -> NavigationTuple {
        return buildArray(components)
    }
}
