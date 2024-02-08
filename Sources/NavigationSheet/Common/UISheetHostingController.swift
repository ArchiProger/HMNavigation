//
//  UISheetHostingController.swift
//
//
//  Created by Archibbald on 07.02.2024.
//

import SwiftUI

final class UISheetHostingController<Content: View>: UIHostingController<AnyView> {
    var shadow: UIShadow?
    var environments: EnvironmentValues = .init()
    var swiftUIView: () -> Content
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    init(@ViewBuilder rootView: @escaping () -> Content) {
        self.swiftUIView = rootView
        super.init(rootView: AnyView(EmptyView()))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateEnvironments()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        updateEnvironments()
    }
    
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
    
    private func updateEnvironments() {
        let scheme = traitCollection.userInterfaceStyle
        let swiftUIScheme: ColorScheme = switch scheme {
            case .unspecified: .light
            case .light: .light
            case .dark: .dark
        }
        
        rootView = .init(
            swiftUIView()
                .environment(\.colorScheme, swiftUIScheme)
                .environment(\.self, environments)
        )
    }
}
