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
        let settings: CustomButton.Settings = .pushChild2ScreenFromMain
        let bt = UIButton()
        bt.setTitle(settings.title(), for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.backgroundColor = .gray
        bt.tag = settings.rawValue

        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red.withAlphaComponent(0.2)
        title = "vc-second"
        
        configureButtons()
    }
    
}

extension VCMain2 {
    @objc func btTapped(sender: UIButton) {
        try? DefaultRouter().navigate(to: ConfigurationHolder.configuration.pushChild2ScreenFromMain, with: nil)
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
