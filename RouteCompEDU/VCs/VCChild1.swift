//
//  VCChild1.swift
//  RouteCompEDU
//
//  Created by Mikhail Yudin on 12.04.2024.
//

import UIKit
import RouteComposer

class VCChild1: UIViewController {
    
    let buttons: [CustomButton] = [
        .init(settings: .openTabMainScreen),
        .init(settings: .openTabSecondScreen),
        .init(settings: .pushChild1ScreenFromMain),
        .init(settings: .pushChild2ScreenFromMain),
        .init(settings: .modalChild1ScreenMain),
        .init(settings: .dismiss),
        .init(settings: .pushVCChild1FromCurrent),
        .init(settings: .pushVCChild2FromCurrent),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange.withAlphaComponent(0.9)
        title = "vc-child-1"

        configureButtons()
    }
    
}

extension VCChild1 {
    func configureButtons() {
        var lastButton: CustomButton? = nil
        buttons.forEach { button in
            button.onTap = { button in
                if button.settings == .dismiss {
                    self.dismiss(animated: true)
                }
            }
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
            button.addTarget(CustomButton.self, action: #selector(CustomButton.btTapped), for: .touchUpInside)
            lastButton = button
        }
    }
}


