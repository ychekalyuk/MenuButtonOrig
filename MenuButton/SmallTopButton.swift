//
//  SmallTopButton.swift
//  MenuButton
//
//  Created by Юрий Альт on 19.05.2023.
//

import UIKit.UIButton

enum MenuButtonType: String {
    case stake = "Stake"
    case send = "Send"
    case receive = "Receive"
    case supply = "Supply"
    case borrow = "Borrow"
    case menu
    
    var imageName: String {
        switch self {
        case .menu:
            return "menuButton"
        case .stake:
            return "stakeLogo"
        case .send:
            return "sendLogo"
        case .receive:
            return "receiveLogo"
        case .supply:
            return "supplyLogo"
        case .borrow:
            return "borrowLogo"
        }
    }
}

extension UIButton {
    convenience init(type: MenuButtonType) {
        self.init()
        let buttonImage = UIImage(named: type.imageName)
        setImage(buttonImage, for: .normal)
        alpha = type == .menu ? 1 : 0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = type == .menu ? 0.6 : 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = type == .menu ? 35 : 13
        layer.masksToBounds = false
    }
}
