//
//  CustomButton.swift
//  RouteCompEDU
//
//  Created by Mikhail Yudin on 12.04.2024.
//

import UIKit

class CustomButton: UIButton {
    enum Settings: Int {
        case openVCMain1
        case openVCMain2
        case pushVCChild1
        case pushVCChild2
        
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
            }
        }
    }
    
    let settings: Settings
    
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
    
}
