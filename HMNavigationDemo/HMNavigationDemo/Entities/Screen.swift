//
//  Screen.swift
//  NavigationSheetDemo
//
//  Created by Archibbald on 22.01.2024.
//

import Foundation
import SwiftUI

enum Screen: String, CaseIterable {
    case home = "Home"
    case detail = "Detail"
    
    var icon: Image {
        switch self {
            case .home: return Image(systemName: "house.fill")
            case .detail: return Image(systemName: "globe")
        }
    }
}
