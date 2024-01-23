//
//  File.swift
//  
//
//  Created by Archibbald on 23.01.2024.
//

import SwiftUI

public typealias SheetDismissAction = () -> Void

// Create an environment key
private struct SheetDismiss: EnvironmentKey {
    static let defaultValue: SheetDismissAction = { }
}

// ## Introduce new value to EnvironmentValues
extension EnvironmentValues {
    public var sheetDismiss: SheetDismissAction {
        get { self[SheetDismiss.self] }
        set { self[SheetDismiss.self] = newValue }
    }
}
