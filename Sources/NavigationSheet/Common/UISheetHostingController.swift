//
//  UISheetHostingController.swift
//
//
//  Created by Archibbald on 07.02.2024.
//

import SwiftUI

final class UISheetHostingController<Content: View>: UIHostingController<Content> {
    var shadow: UIShadow?
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let shadow {
            var superview = view.superview
            while superview != nil {
                superview?.layer.backgroundColor = UIColor.clear.cgColor
                superview?.layer.shadowColor = shadow.color
                superview?.layer.shadowRadius = shadow.radius
                superview?.layer.shadowPath = shadow.path
                superview?.layer.shadowOffset = shadow.offset
                superview = superview?.superview
            }
        }
    }
}
