//
//  File.swift
//  
//
//  Created by Archibbald on 25.01.2024.
//

import SwiftUI
import NavigationTabBar

// Create an environment key
private struct HostingViewController: EnvironmentKey {
    static let defaultValue: UIViewController? = nil
}

// ## Introduce new value to EnvironmentValues
extension EnvironmentValues {
    var hostingController: UIViewController? {
        get { self[HostingViewController.self] }
        set { self[HostingViewController.self] = newValue }
    }
}
