//
//  TabBarSize.swift
//
//
//  Created by Archibbald on 20.03.2024.
//

import SwiftUI

// Create an environment key
private struct TabBarEnvironment: EnvironmentKey {
    static let defaultValue: CGSize = .zero
}

// ## Introduce new value to EnvironmentValues
extension EnvironmentValues {
    public var tabBarSize: CGSize {
        get { self[TabBarEnvironment.self] }
        set { self[TabBarEnvironment.self] = newValue }
    }
}
