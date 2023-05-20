//
//  SmallTopButton.swift
//  MenuButton
//
//  Created by Юрий Альт on 19.05.2023.
//

import UIKit.UIButton

enum MenuButtonType: String {
    case menu
    case stake
    case send
    case receive
    case supply
    case borrow
}

extension UIButton {
    convenience init(type: MenuButtonType) {
        self.init()
        let buttonImage = UIImage(named: String(describing: type))
        setImage(buttonImage, for: .normal)
        alpha = type == .menu ? 1 : 0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = type == .menu ? 0.6 : 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = type == .menu ? 35 : 13
        layer.masksToBounds = false
    }
}
