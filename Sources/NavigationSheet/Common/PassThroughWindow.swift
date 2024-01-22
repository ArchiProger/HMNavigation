//
//  File.swift
//  
//
//  Created by Archibbald on 22.01.2024.
//

import UIKit

final class PassThroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // Get view from superclass.
        guard let hitView = super.hitTest(point, with: event) else { return nil }
        // If the returned view is the `UIHostingController`'s view, ignore.
        return rootViewController?.view == hitView ? nil : hitView
    }
}
