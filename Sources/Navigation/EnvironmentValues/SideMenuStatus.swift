//
//  SideMenuStatus.swift
//  
//
//  Created by Archibbald on 07.03.2024.
//

import Foundation
import SwiftUI

public enum SideMenuStatus {
    case active, inactive
    
    public func toggle() {
        NavigationViewModel.shared.isActive.toggle()
    }
}

// Create an environment key
private struct SideMenuStatusEnvironment: EnvironmentKey {
    static let defaultValue: SideMenuStatus = .inactive
}

// ## Introduce new value to EnvironmentValues
extension EnvironmentValues {
    public var sideMenuStatus: SideMenuStatus {
        get { self[SideMenuStatusEnvironment.self] }
        set { self[SideMenuStatusEnvironment.self] = newValue }
    }
}

