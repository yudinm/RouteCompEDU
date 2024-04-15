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
        .init(settings: .openTabMainScreen),
        .init(settings: .openTabSecondScreen),
        .init(settings: .pushChild1ScreenFromMain),
        .init(settings: .pushChild2ScreenFromMain),
        .init(settings: .modalChild1ScreenMain),
        .init(settings: .modalChild1ScreenFromCurrentWithNavigationController),
        .init(settings: .modalChild1ScreenFromCurrentWithNavigationControllerThenPushChild2),
        .init(settings: .dismiss),
        .init(settings: .pushVCChild1FromCurrent),
        .init(settings: .pushVCChild2FromCurrent),
        .init(settings: .pushVCChild1FromCurrentInfinity),
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
            button.onTap = { button in
                if button.settings == .dismiss {
                    self.dismiss(animated: true)
                }
            }
            if (lastButton == nil) {
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                ])
            } else {
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: lastButton!.bottomAnchor, constant: 8),
                    button.heightAnchor.constraint(equalTo: lastButton!.heightAnchor),
                ])
            }
            NSLayoutConstraint.activate([
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
                
            ])
            button.addTarget(CustomButton.self, action: #selector(CustomButton.btTapped), for: .touchUpInside)
            lastButton = button
        }
        
        NSLayoutConstraint.activate([
            lastButton!.bottomAnchor.constraint(greaterThanOrEqualTo: view.layoutMarginsGuide.bottomAnchor, constant: -88)
        ])
    }
}

