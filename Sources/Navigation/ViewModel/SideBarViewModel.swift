//
//  SideBarViewModel.swift
//
//
//  Created by Archibbald on 05.03.2024.
//

import Foundation
import SwiftUI
import Combine

enum GestureDirection {
    case left, right
}

final class SideBarViewModel: ObservableObject {
    @Published var isActive = false
    @Published var isGesture = true
    
    @Published var width: CGFloat = .zero
    @Published var x: CGFloat = .zero
    
    @Published private(set) var direction: GestureDirection? = nil
    @Published private var position: CGFloat = .zero
    
    private var cancellable: Set<AnyCancellable> = []
    
    static let shared = SideBarViewModel()
    
    private init() {
        $position
            .receive(on: RunLoop.main)            
            .filter { (-self.width...0).contains($0) }
            .sink { value in
                withAnimation {
                    self.x = value
                }
            }
            .store(in: &cancellable)
        
        $isActive
            .receive(on: RunLoop.main)
            .map { $0 ? 0 : -self.width }
            .assign(to: \.position, on: self)
            .store(in: &cancellable)
    }
    
    var gesture: some Gesture {
        let distanceRestriction: CGFloat = 50
                        
        return DragGesture(minimumDistance: distanceRestriction)
            .onChanged { value in
                let width = value.translation.width
                
                guard abs(width) >= distanceRestriction, self.isGesture else { return }
                
                if self.direction == nil {
                    self.direction = width > 0 ? .right : .left
                }
                
                self.position = switch self.direction {
                    case .left:
                        width
                    case .right:
                        width - self.width
                    case nil:
                        self.position
                }
            }
            .onEnded { value in
                guard self.isGesture else { return }
                
                let condition = -self.position < self.width / 2
                
                self.isActive = condition
                self.direction = nil
            }
    }
}
