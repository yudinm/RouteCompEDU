//
//  CustomButton.swift
//  RouteCompEDU
//
//  Created by Mikhail Yudin on 12.04.2024.
//

import UIKit
import RouteComposer

class CustomButton: UIButton {
    enum Settings: Int {
        case openVCMain1
        case openVCMain2
        case pushVCChild1
        case pushVCChild2
        case presentVCChild1
        case dismiss
        
        func title() -> String {
            switch self {
            case .openVCMain1:
                return "openVCMain1"
            case .openVCMain2:
                return "openVCMain2"
            case .pushVCChild1:
                return "pushVCChild1"
            case .pushVCChild2:
                return "pushVCChild2"
            case .presentVCChild1:
                return "presentVCChild1"
            case .dismiss:
                return "Dismiss"
            }
        }
    }
    
    let settings: Settings
    var onTap: ((_ sender: CustomButton)->())?
    
    init(settings: Settings) {
        self.settings = settings
        super.init(frame: .zero)
        setTitle(settings.title(), for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .gray
        tag = settings.rawValue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc static func btTapped(sender: CustomButton) {
        let settings = sender.settings
        let router = DefaultRouter()
        let config = ConfigurationHolder.configuration
        switch settings {
        case .openVCMain1:
            try? router.navigate(to: config.mainScreen, with: nil)
        case .openVCMain2:
            try? router.navigate(to: config.secondScreen, with: nil)
        case .pushVCChild1:
            try? router.navigate(to: config.child1Screen, with: nil)
        case .pushVCChild2:
            try? router.navigate(to: config.child2Screen, with: nil)
        case .presentVCChild1:
            try? router.navigate(to: config.child1ScreenModal, with: nil)
        case .dismiss:
            break
        }
        sender.onTap?(sender)
    }
}
