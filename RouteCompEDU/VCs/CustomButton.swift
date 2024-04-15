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
        case openTabMainScreen
        case openTabSecondScreen
        case pushChild1ScreenFromMain
        case pushChild2ScreenFromMain
        case modalChild1ScreenMain
        case dismiss
        case pushVCChild1FromCurrent
        case pushVCChild2FromCurrent
        case modalChild1ScreenFromCurrentWithNavigationController
        
        func title() -> String {
            switch self {
            case .openTabMainScreen:
                return "openTabMainScreen"
            case .openTabSecondScreen:
                return "openTabSecondScreen"
            case .pushChild1ScreenFromMain:
                return "pushChild1ScreenFromMain"
            case .pushChild2ScreenFromMain:
                return "pushChild2ScreenFromMain"
            case .modalChild1ScreenMain:
                return "modalChild1ScreenMain"
            case .dismiss:
                return "Dismiss"
            case .pushVCChild1FromCurrent:
                return "pushVCChild1FromCurrent"
            case .pushVCChild2FromCurrent:
                return "pushVCChild2FromCurrent"
            case .modalChild1ScreenFromCurrentWithNavigationController:
                return "modalChild1ScreenFromCurrentWithNavigationController"
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
        case .openTabMainScreen:
            try? router.navigate(to: config.openTabMainScreen, with: nil)
        case .openTabSecondScreen:
            try? router.navigate(to: config.openTabSecondScreen, with: nil)
        case .pushChild1ScreenFromMain:
            try? router.navigate(to: config.pushChild1ScreenFromMain, with: nil)
        case .pushChild2ScreenFromMain:
            try? router.navigate(to: config.pushChild2ScreenFromMain, with: nil)
        case .modalChild1ScreenMain:
            try? router.navigate(to: config.modalChild1ScreenMain, with: nil)
        case .dismiss:
            break
        case .pushVCChild1FromCurrent:
            try? router.navigate(to: config.pushVCChild1FromCurrent, with: nil)
        case .pushVCChild2FromCurrent:
            try? router.navigate(to: config.pushVCChild2FromCurrent, with: nil)
        case .modalChild1ScreenFromCurrentWithNavigationController:
            try? router.navigate(to: config.modalChild1ScreenFromCurrentWithNavigationController, with: nil)
        }
        sender.onTap?(sender)
    }
}
