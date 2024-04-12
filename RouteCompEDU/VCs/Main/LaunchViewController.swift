//
//  LaunchViewController.swift
//  RouteCompEDU
//
//  Created by Mikhail Yudin on 12.04.2024.
//

import Foundation
import UIKit

class LaunchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Hello"
        view.accessibilityIdentifier = "LaunchViewController.View"
        view.backgroundColor = .systemBackground
        configureHelloView()
    }
}

extension LaunchViewController {
    func configureHelloView() {
        let hello = UILabel()
        hello.text = "Hello 🏄🏿"
        hello.font = .boldSystemFont(ofSize: 44)
        hello.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hello)
        hello.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hello.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
