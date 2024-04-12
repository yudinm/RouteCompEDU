//
//  VCChild2.swift
//  RouteCompEDU
//
//  Created by Mikhail Yudin on 12.04.2024.
//

import UIKit
import RouteComposer

class VCChild2: UIViewController {
    
    let buttons: [CustomButton] = [
        .init(settings: .openVCMain1),
        .init(settings: .openVCMain2),
        .init(settings: .pushVCChild1),
        .init(settings: .pushVCChild2),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow.withAlphaComponent(0.2)
        title = "vc-child-2"
        
        configureButtons()
    }
    
}

extension VCChild2 {
    func configureButtons() {
        var lastButton: CustomButton? = nil
        buttons.forEach { button in
            view.addSubview(button)
            if (lastButton == nil) {
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                ])
            } else {
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: lastButton!.bottomAnchor, constant: 8)
                ])
            }
            NSLayoutConstraint.activate([
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
            button.addTarget(self, action: #selector(btTapped), for: .touchUpInside)
            lastButton = button
        }
    }
}

extension VCChild2 {
    @objc func btTapped(sender: CustomButton) {
        let settings = sender.settings
        switch settings {
        case .openVCMain1:
            try? DefaultRouter().navigate(to: ConfigurationHolder.configuration.mainScreen, with: nil)
        case .openVCMain2:
            try? DefaultRouter().navigate(to: ConfigurationHolder.configuration.secondScreen, with: nil)
        case .pushVCChild1:
            try? DefaultRouter().navigate(to: ConfigurationHolder.configuration.child1Screen, with: nil)
        case .pushVCChild2:
            try? DefaultRouter().navigate(to: ConfigurationHolder.configuration.child2Screen, with: nil)
        }
    }
}
