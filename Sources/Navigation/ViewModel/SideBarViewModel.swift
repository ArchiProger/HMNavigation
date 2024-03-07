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
    
    @Published var width: CGFloat = .zero
    @Published var x: CGFloat = .zero
    
    @Published private var position: CGFloat = .zero
    @Published private var direction: GestureDirection? = nil
    
    private var cancellable: Set<AnyCancellable> = []
    
    static let shared = SideBarViewModel()
    
    private init() {
        $position
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .filter { (-self.width...0).contains($0) }
            .sink { value in
                withAnimation {
                    self.x = value
                }
            }
            .store(in: &cancellable)
        
        $position
            .dropFirst()
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .map { !($0 == -self.width) }
            .filter { $0 == true }
            .assign(to: \.isActive, on: self)
            .store(in: &cancellable)
        
        $position
            .dropFirst()
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .map { $0 == 0 }
            .filter { $0 == false }
            .assign(to: \.isActive, on: self)
            .store(in: &cancellable)
        
        $isActive
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { value in
                withAnimation {
                    self.x = value ? 0 : -self.width
                }
            }
            .store(in: &cancellable)
    }
    
    var gesture: some Gesture {
        DragGesture(minimumDistance: 30)
            .onChanged { value in
                let width = value.translation.width
                
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
                if -self.position < self.width / 2 {
                    self.position = 0
                } else{
                    self.position = -self.width
                }
                
                self.direction = nil
            }
    }
}
