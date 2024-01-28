//
//  Screen.swift
//  NavigationSheetDemo
//
//  Created by Archibbald on 22.01.2024.
//

import Foundation
import SwiftUI

enum Screen: String, CaseIterable {
    case tree = "Sheets Tree"
    case sheets = "Sheets"
    case detail = "Detail"
    
    var icon: Image {
        switch self {
            case .tree: return Image(systemName: "tree.fill")
            case .detail: return Image(systemName: "scroll.fill")
            case .sheets: return Image(systemName: "platter.filled.bottom.and.arrow.down.iphone")
        }
    }
}
