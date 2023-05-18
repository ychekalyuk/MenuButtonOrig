//
//  MainViewController.swift
//  MenuButton
//
//  Created by Юрий Альт on 18.05.2023.
//

import UIKit

class MainViewController: UIViewController {
    //MARK: - Views
    private lazy var translucentView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blurEffect)
        view.alpha = 0
        return view
    }()
    
    private lazy var testBackgroundText: UILabel = {
        let label = UILabel()
        label.text = "This is the test label for testing blur view effect"
        label.font = UIFont.systemFont(ofSize: 50)
        label.numberOfLines = 0
        label.textColor = .blue
        return label
    }()
    
    private lazy var menuButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "menuButton")
        button.setImage(buttonImage, for: .normal)
        return button
    }()
    
    //MARK: - Five Menu Buttons
    private lazy var stakeButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "menuButton")
        button.setImage(buttonImage, for: .normal)
        button.alpha = 0
        return button
    }()
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "menuButton")
        button.setImage(buttonImage, for: .normal)
        button.alpha = 0
        return button
    }()
    
    
    private lazy var recieveButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "menuButton")
        button.setImage(buttonImage, for: .normal)
        button.alpha = 0
        return button
    }()
    
    private lazy var supplyButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "menuButton")
        button.setImage(buttonImage, for: .normal)
        button.alpha = 0
        return button
    }()
    private lazy var borrowButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "menuButton")
        button.setImage(buttonImage, for: .normal)
        button.alpha = 0
        return button
    }()
    //MARK: - Constraints
    
    private lazy var stakeButtonLeftConstraint = stakeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: centerX)
    private lazy var stakeButtonBottomConstraint = stakeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                                                       constant: -50)
    private lazy var sendButtonLeftConstraint = sendButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: centerX)
    private lazy var sendButtonBottomConstraint = sendButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
    
    private lazy var recieveButtonBottomConstraint = recieveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                                                           constant: -50)
    private lazy var supplyButtonRightConstraint = supplyButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -centerX)
    private lazy var supplyButtonBottomConstraint = supplyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
    private lazy var borrowButtonRightConstraint = borrowButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -centerX)
    private lazy var borrowButtonBottomConstraint = borrowButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
    
    //MARK: - Private Properties
    let centerX = UIScreen.main.bounds.width / 2
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRecognizers()
    }
}

//MARK: - Setup Gesture Recognizers
private extension MainViewController {
    func setupRecognizers() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(buttonLongPressed(_:)))
        longPressGesture.minimumPressDuration = 0.2
        menuButton.addGestureRecognizer(longPressGesture)
    }
}

//MARK: - Actions
private extension MainViewController {
    @objc func buttonLongPressed(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
            
        case .began:
            UIView.animate(withDuration: 0.1) {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred(intensity: 1)
                self.translucentView.alpha = 1
                self.stakeButton.alpha = 1
                self.sendButton.alpha = 1
                self.recieveButton.alpha = 1
                self.supplyButton.alpha = 1
                self.borrowButton.alpha = 1
                self.setupButtonsDynamicConstraints(isBegan: true)
            }
            UIView.animate(withDuration: 0.2) {
                self.menuButton.alpha = 0
            }
        case .ended:
            UIView.animate(withDuration: 0.1) {
                self.translucentView.alpha = 0
                self.menuButton.alpha = 1
                self.setupButtonsDynamicConstraints(isBegan: false)
                self.stakeButton.alpha = 0
                self.sendButton.alpha = 0
                self.recieveButton.alpha = 0
                self.supplyButton.alpha = 0
                self.borrowButton.alpha = 0
                
            }
            UIView.animate(withDuration: 0.2) {
                self.menuButton.alpha = 1
            }
        default:
            break
        }
    }
    
    private func setupButtonsDynamicConstraints(isBegan: Bool) {
        if isBegan {
            stakeButtonBottomConstraint.constant = -120
            stakeButtonLeftConstraint.constant = 24
            sendButtonBottomConstraint.constant = -140
            sendButtonLeftConstraint.constant = 100
            recieveButtonBottomConstraint.constant = -150
            supplyButtonBottomConstraint.constant = -140
            supplyButtonRightConstraint.constant = -100
            borrowButtonBottomConstraint.constant = -120
            borrowButtonRightConstraint.constant = -24
        } else {
            stakeButtonBottomConstraint.constant = -50
            stakeButtonLeftConstraint.constant = centerX
            sendButtonBottomConstraint.constant = -50
            sendButtonLeftConstraint.constant = centerX
            recieveButtonBottomConstraint.constant = -50
            supplyButtonBottomConstraint.constant = -50
            supplyButtonRightConstraint.constant = -centerX
            borrowButtonBottomConstraint.constant = -50
            borrowButtonRightConstraint.constant = -centerX
        }
        
        UIView.animate(withDuration: 0.6) {
            let buttons = [self.stakeButton, self.sendButton, self.recieveButton, self.supplyButton, self.borrowButton]
            if isBegan {
                buttons.forEach { button in
                    button.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }
            } else {
                buttons.forEach { button in
                    button.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
                }
            }
            self.view.layoutIfNeeded()
        }
    }
}

//MARK: - UI & Layout
private extension MainViewController {
    func setupUI() {
        view.backgroundColor = .white
        view.addAutolayoutSubviews(testBackgroundText,
                                   translucentView,
                                   menuButton,
                                   stakeButton,
                                   sendButton,
                                   recieveButton,
                                   supplyButton,
                                   borrowButton)
        setupConstraints()
    }
    
    func setupConstraints() {
        let topButtonsSize: CGFloat = 55
        NSLayoutConstraint.activate([
            testBackgroundText.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            testBackgroundText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100),
            testBackgroundText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100),
            
            translucentView.topAnchor.constraint(equalTo: view.topAnchor),
            translucentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            translucentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            translucentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            menuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            menuButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            menuButton.heightAnchor.constraint(equalToConstant: 80),
            menuButton.widthAnchor.constraint(equalToConstant: 80),

            stakeButtonLeftConstraint,
            stakeButtonBottomConstraint,
            stakeButton.heightAnchor.constraint(equalToConstant: topButtonsSize),
            stakeButton.widthAnchor.constraint(equalToConstant: topButtonsSize),
            
            sendButtonLeftConstraint,
            sendButtonBottomConstraint,
            sendButton.heightAnchor.constraint(equalToConstant: topButtonsSize),
            sendButton.widthAnchor.constraint(equalToConstant: topButtonsSize),
            
            recieveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recieveButton.heightAnchor.constraint(equalToConstant: topButtonsSize),
            recieveButton.widthAnchor.constraint(equalToConstant: topButtonsSize),
            recieveButtonBottomConstraint,
            
            supplyButtonRightConstraint,
            supplyButtonBottomConstraint,
            supplyButton.heightAnchor.constraint(equalToConstant: topButtonsSize),
            supplyButton.widthAnchor.constraint(equalToConstant: topButtonsSize),
            
            borrowButtonRightConstraint,
            borrowButtonBottomConstraint,
            borrowButton.heightAnchor.constraint(equalToConstant: topButtonsSize),
            borrowButton.widthAnchor.constraint(equalToConstant: topButtonsSize),
        ])
    }
}

