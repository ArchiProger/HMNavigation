//
//  File.swift
//  
//
//  Created by Archibbald on 23.01.2024.
//

import SwiftUI

struct Size: PreferenceKey {
    
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        
        value = nextValue()
    }
}

extension View {    
    func size(perform: @escaping (CGSize) -> Void) -> some View {
        self
            .background {
                GeometryReader { geometry in                    
                    Color.clear
                        .preference(key: Size.self, value: geometry.size)
                        .onPreferenceChange(Size.self, perform: perform)
                }
            }
    }
}

