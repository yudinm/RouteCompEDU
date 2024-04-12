//
//  VC-main-2.swift
//  RouteCompEDU
//
//  Created by Mikhail Yudin on 07.09.2023.
//

import UIKit
import RouteComposer

class VCMain2: UIViewController {
    
    var bt: UIButton = {
        let bt = UIButton()
        bt.setTitle("Push child `vc-child-2` from main screen", for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.backgroundColor = .gray

        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green.withAlphaComponent(0.2)
        title = "Second screen"
        
        configureButtons()
    }
    
}

extension VCMain2 {
    @objc func btTapped(sender: UIButton) {
        try? DefaultRouter().navigate(to: ConfigurationHolder.configuration.child2Screen, with: nil)
    }
}

extension VCMain2 {
    func configureButtons() {
        view.addSubview(bt)
        NSLayoutConstraint.activate([
            bt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bt.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        bt.addTarget(self, action: #selector(btTapped), for: .touchUpInside)
    }
}
