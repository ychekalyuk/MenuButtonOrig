//
//  UILabel+Extension.swift
//  MenuButton
//
//  Created by Юрий Альт on 20.05.2023.
//

import UIKit.UILabel

extension UILabel {
    convenience init(text: String) {
        self.init()
        self.text = text
        textColor = .gray
        font = UIFont.boldSystemFont(ofSize: 15)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 2
        layer.masksToBounds = false
    }
}
