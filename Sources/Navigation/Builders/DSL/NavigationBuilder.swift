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
    public static func buildBlock<Content: NavigationContent>(_ components: Content...) -> NavigationTuple {
        let adapter = WindowsAdapter.shared
        guard
            let root = adapter.navigation?.rootViewController,
            let controller = root as? UIHostingController<NavigationTuple>
        else { return .init() }
        
        for component in components {
            let view = controller.rootView
            
            switch component.placement {
                case .tabBar:
                    controller.rootView = view.placeBottomBar { component.body }
                    
                case .sideMenu:
                    break
            }
        }                
                
        return controller.rootView
    }
    
    public static func buildEither<Content: NavigationContent>(first component: Content) -> NavigationTuple {
        return buildBlock(component)
    }        
    
    public static func buildEither<Content: NavigationContent>(second component: Content) -> NavigationTuple {
        return buildBlock(component)
    }
    
    public static func buildArray<Content: NavigationContent>(_ components: [Content]) -> NavigationTuple {
        return buildArray(components)
    }
}
