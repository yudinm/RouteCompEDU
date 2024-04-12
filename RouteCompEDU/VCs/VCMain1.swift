//
//  VC-main-1.swift
//  RouteCompEDU
//
//  Created by Mikhail Yudin on 07.09.2023.
//

import UIKit
import RouteComposer

class VCMain1: UIViewController {
    
    var bt: UIButton = {
        let bt = UIButton()
        bt.setTitle("Push child vc", for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.backgroundColor = .gray

        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green.withAlphaComponent(0.2)
        title = "Main screen"
        
        configureButtons()
    }
    
}

extension VCMain1 {
    @objc func btTapped(sender: UIButton) {
        try? DefaultRouter().navigate(to: ConfigurationHolder.configuration.child1Screen, with: nil)
    }
}

extension VCMain1 {
    func configureButtons() {
        view.addSubview(bt)
        NSLayoutConstraint.activate([
            bt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bt.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        bt.addTarget(self, action: #selector(btTapped), for: .touchUpInside)
    }
}
