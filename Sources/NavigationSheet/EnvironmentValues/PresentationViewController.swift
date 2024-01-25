//
//  File.swift
//  
//
//  Created by Archibbald on 25.01.2024.
//

import SwiftUI

// Create an environment key
private struct PresentationViewController: EnvironmentKey {
    static let defaultValue: SheetControllersViewModel = .init()
}

// ## Introduce new value to EnvironmentValues
extension EnvironmentValues {
    var sheetController: SheetControllersViewModel {
        get { self[PresentationViewController.self] }
        set { self[PresentationViewController.self] = newValue }
    }
}
