//
//  File.swift
//  
//
//  Created by Archibbald on 23.01.2024.
//

import SwiftUI

// Create an environment key
private struct TabBarSize: EnvironmentKey {
    static let defaultValue: CGSize = .zero
}

// ## Introduce new value to EnvironmentValues
extension EnvironmentValues {
    var tabBarSize: CGSize {
        get { self[TabBarSize.self] }
        set { self[TabBarSize.self] = newValue }
    }
}
