//
//  VC-main-1.swift
//  RouteCompEDU
//
//  Created by Mikhail Yudin on 07.09.2023.
//

import UIKit
import RouteComposer

class VCMain1: UIViewController {
    
    let buttons: [CustomButton] = [
        .init(settings: .openTabMainScreen),
        .init(settings: .openTabSecondScreen),
        .init(settings: .pushChild1ScreenFromMain),
        .init(settings: .pushChild2ScreenFromMain),
        .init(settings: .modalChild1ScreenMain),
        .init(settings: .pushVCChild1FromCurrent),
        .init(settings: .pushVCChild2FromCurrent),
        .init(settings: .modalChild1ScreenFromCurrentWithNavigationController),
        .init(settings: .modalChild1ScreenFromCurrentWithNavigationControllerThenPushChild2),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green.withAlphaComponent(0.2)
        title = "vc-main"
        
        configureButtons()
    }
    
}

extension VCMain1 {
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

