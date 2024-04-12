//
//  VCChild2.swift
//  RouteCompEDU
//
//  Created by Mikhail Yudin on 12.04.2024.
//

import UIKit
import RouteComposer

class VCChild2: UIViewController {
    
    var bt: UIButton = {
        let bt = UIButton()
        bt.setTitle("Push child `vc-child-1` from main screen", for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.backgroundColor = .gray

        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow.withAlphaComponent(0.9)
        title = "vc-child-2"
        
        configureButtons()
    }
    
}

extension VCChild2 {
    @objc func btTapped(sender: UIButton) {
        try? DefaultRouter().navigate(to: ConfigurationHolder.configuration.child1Screen, with: nil)
    }
}

extension VCChild2 {
    func configureButtons() {
        view.addSubview(bt)
        NSLayoutConstraint.activate([
            bt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bt.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        bt.addTarget(self, action: #selector(btTapped), for: .touchUpInside)
    }
}
