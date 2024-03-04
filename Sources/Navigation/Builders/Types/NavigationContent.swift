//
//  NavigationContent.swift
//
//
//  Created by Archibbald on 04.03.2024.
//

import Foundation
import SwiftUI

public protocol NavigationContent {
    associatedtype Body: View
    
    var placement: NavigationPlacement { get }
    @ViewBuilder var body: Body { get }
}
