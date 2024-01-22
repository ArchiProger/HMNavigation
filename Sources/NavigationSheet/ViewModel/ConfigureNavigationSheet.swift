//
//  File.swift
//  
//
//  Created by Archibbald on 22.01.2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    public func configureNavigationSheets() -> some View {
        self
            .environmentObject(SheetViewModel.shared)
    }
}
