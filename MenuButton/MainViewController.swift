//
//  MainViewController.swift
//  MenuButton
//
//  Created by Юрий Альт on 18.05.2023.
//

import UIKit

class MainViewController: UIViewController {
    //MARK: - Views
    private lazy var menuButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "menuButton")
        button.setImage(buttonImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupUI()
    }
}

//MARK: - UI & Layout
private extension MainViewController {
    func setupUI() {
        view.addSubview(menuButton)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            menuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            menuButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            menuButton.heightAnchor.constraint(equalToConstant: 80),
            menuButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
}

