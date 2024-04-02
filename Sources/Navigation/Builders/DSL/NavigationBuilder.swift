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
        var view = NavigationTuple()
        
        for component in components {
            view = switch component.placement {
                case .tabBar:
                     view.placeBottomBar { AnyView(component.body) }
                case .sideMenu:
                    view.placeSideMenu { AnyView(component.body) }
            }
        }                
                
        return view
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
