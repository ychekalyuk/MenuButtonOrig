//
//  SmallTopButton.swift
//  MenuButton
//
//  Created by Юрий Альт on 19.05.2023.
//

import UIKit

class SmallTopButton: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var smallButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "supplyLogo")
        button.setImage(buttonImage, for: .normal)
        button.alpha = 1
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 13
        button.layer.masksToBounds = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SmallTopButton {
    func setupUI() {
        addAutolayoutSubviews(titleLabel, smallButton)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            smallButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            smallButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            smallButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            smallButton.widthAnchor.constraint(equalToConstant: 55),
            smallButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
