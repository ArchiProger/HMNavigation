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
    case content = "Content changing"
    case detail = "Detail"
    
    var icon: Image {
        switch self {
            case .tree: return Image(systemName: "tree.fill")
            case .detail: return Image(systemName: "scroll.fill")
            case .content: return Image(systemName: "square.3.layers.3d.bottom.filled")
            case .sheets: return Image(systemName: "platter.filled.bottom.and.arrow.down.iphone")
        }
    }
}
