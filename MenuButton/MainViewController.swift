//
//  MainViewController.swift
//  MenuButton
//
//  Created by Юрий Альт on 18.05.2023.
//

import UIKit

class MainViewController: UIViewController {
    //MARK: - Views
    private lazy var mockBackImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "mockBackView")
        imageView.image = image
        return imageView
    }()
    
    private lazy var translucentView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blurEffect)
        view.alpha = 0
        return view
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.alpha = 0
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.2
        label.layer.shadowOffset = CGSize(width: 0, height: 1)
        label.layer.shadowRadius = 2
        label.layer.masksToBounds = false
        return label
    }()
    
    private lazy var menuButton: UIButton = {
        let button = UIButton(type: .menu)
        return button
    }()
    
    private lazy var stakeButton: UIButton = {
        let button = UIButton(type: .stake)
        return button
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .send)
        return button
    }()
    
    private lazy var recieveButton: UIButton = {
        let button = UIButton(type: .receive)
        return button
    }()
    
    private lazy var supplyButton: UIButton = {
        let button = UIButton(type: .supply)
        return button
    }()
    
    private lazy var borrowButton: UIButton = {
        let button = UIButton(type: .borrow)
        return button
    }()
    
    //MARK: - Constraints
    private lazy var stakeButtonLeftConstraint = stakeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: centerX)
    private lazy var stakeButtonBottomConstraint = stakeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                                                       constant: -30)
    private lazy var sendButtonLeftConstraint = sendButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: centerX)
    private lazy var sendButtonBottomConstraint = sendButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
    
    private lazy var recieveButtonBottomConstraint = recieveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                                                           constant: -30)
    private lazy var supplyButtonRightConstraint = supplyButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -centerX)
    private lazy var supplyButtonBottomConstraint = supplyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
    private lazy var borrowButtonRightConstraint = borrowButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -centerX)
    private lazy var borrowButtonBottomConstraint = borrowButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
    
    //MARK: - Private Properties
    private let centerX = UIScreen.main.bounds.width / 2
    private var isButtonsAppeared = false
    private var lastButton: UIButton?
    private var isItMenuButtonLongTap = false
    private var isItFirstTap = true
    private var menuButtonLabels: [UILabel] = []
    
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
        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(menuButtonLongPressed(_:)))
        longPressGesture.minimumPressDuration = 0.2
        menuButton.addGestureRecognizer(longPressGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGesture.delegate = self
        menuButton.addGestureRecognizer(panGesture)
        
        let buttons = [stakeButton, sendButton, recieveButton, supplyButton, borrowButton]
        buttons.forEach { button in
            let smallTopButton = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
            smallTopButton.delegate = self
            button.addGestureRecognizer(smallTopButton)
            let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
            longPressGesture.minimumPressDuration = 0.2
            button.addGestureRecognizer(longPressGesture)
        }
    }
}

//MARK: - UIGestureRecognizerDelegate
extension MainViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

//MARK: - Actions
private extension MainViewController {
    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let buttons = [stakeButton, sendButton, recieveButton, supplyButton, borrowButton]
        let scale: CGFloat = 1.6
        switch sender.state {
        case .began, .changed:
            let location = sender.location(in: view)
            for (index, button) in buttons.enumerated() {
                if button.frame.contains(location) {
                    if lastButton != button {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred(intensity: 1)
                        lastButton = button
                        UIView.animate(withDuration: 0.3) {
                            self.infoLabel.alpha = 1
                            self.infoLabel.text = self.getButtonTitle(for: index)
                            for label in self.menuButtonLabels {
                                label.removeFromSuperview()
                            }
                            self.menuButtonLabels.removeAll()
                        }
                    }
                    let translateTransform: CGAffineTransform
                    if button == stakeButton {
                        translateTransform = CGAffineTransform(translationX: -button.bounds.width * (1 - 1/scale) / 2, y: -button.bounds.height * (1 - 1/scale))
                    } else if button == borrowButton {
                        translateTransform = CGAffineTransform(translationX: button.bounds.width * (1 - 1/scale) / 2, y: -button.bounds.height * (1 - 1/scale))
                    } else {
                        translateTransform = CGAffineTransform(translationX: 0, y: -button.bounds.height * (1 - 1/scale))
                    }
                    UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3) {
                        button.transform = CGAffineTransform(scaleX: scale, y: scale).concatenating(translateTransform)
                    }
                    
                } else {
                    button.transform = CGAffineTransform.identity
                }
            }
        case .ended, .cancelled, .failed:
            UIView.animate(withDuration: 0.6) {
                for button in buttons {
                    button.transform = CGAffineTransform.identity
                }
            }
            UIView.animate(withDuration: 0.1) {
                self.infoLabel.alpha = 0
            }
            lastButton = nil
        default:
            break
        }
    }
    
    @objc func menuButtonTapped() {
        if !isItMenuButtonLongTap {
            if isItFirstTap {
                let buttons = [stakeButton, sendButton, recieveButton, supplyButton, borrowButton]
                for (index, button) in buttons.enumerated() {
                    let label = UILabel(text: getButtonTitle(for: index))
                    view.addAutolayoutSubview(label)
                    NSLayoutConstraint.activate([
                        label.centerXAnchor.constraint(equalTo: button.centerXAnchor),
                        label.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10)
                    ])
                    menuButtonLabels.append(label)
                    isItFirstTap.toggle()
                }
            } else {
                for label in menuButtonLabels {
                    label.removeFromSuperview()
                }
                menuButtonLabels.removeAll()
                isItFirstTap.toggle()
            }
        }
        
        isButtonsAppeared.toggle()
        if isButtonsAppeared {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3) {
                self.setupButtons(isMenuButtonExpanded: self.isButtonsAppeared)
                self.menuButton.alpha = 1
            }
            let expandedButtonImage = UIImage(named: "closeButton")
            menuButton.setImage(expandedButtonImage, for: .normal)
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3) {
                self.setupButtons(isMenuButtonExpanded: self.isButtonsAppeared)
            }
            let normalButtonImage = UIImage(named: "menuButton")
            menuButton.setImage(normalButtonImage, for: .normal)
        }
    }
    
    @objc func menuButtonLongPressed(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            isItMenuButtonLongTap.toggle()
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3) {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred(intensity: 1)
                self.setupButtons(isMenuButtonExpanded: true)
            }
            UIView.animate(withDuration: 0.2) {
                self.menuButton.alpha = 0
            }
        case .ended:
            isItMenuButtonLongTap.toggle()
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3) {
                self.setupButtons(isMenuButtonExpanded: false)
                
            }
            UIView.animate(withDuration: 0.2) {
                self.menuButton.alpha = 1
            }
        default:
            break
        }
    }
    
    func getButtonTitle(for index: Int) -> String {
        switch index {
        case 0:
            return MenuButtonType.stake.rawValue
        case 1:
            return MenuButtonType.send.rawValue
        case 2:
            return MenuButtonType.receive.rawValue
        case 3:
            return MenuButtonType.supply.rawValue
        case 4:
            return MenuButtonType.borrow.rawValue
        default:
            return ""
        }
    }
    
    func setupButtons(isMenuButtonExpanded: Bool) {
        if isMenuButtonExpanded {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred(intensity: 1)
            [translucentView, stakeButton, sendButton, recieveButton, supplyButton, borrowButton].forEach { $0.alpha = 1 }
            self.setupButtonsDynamicConstraints(isBegan: true)
        } else {
            [translucentView, stakeButton, sendButton, recieveButton, supplyButton, borrowButton].forEach { $0.alpha = 0 }
            self.setupButtonsDynamicConstraints(isBegan: false)
        }
    }
    
    func setupButtonsDynamicConstraints(isBegan: Bool) {
        if isBegan {
            stakeButtonBottomConstraint.constant = -90
            stakeButtonLeftConstraint.constant = 35
            sendButtonBottomConstraint.constant = -110
            sendButtonLeftConstraint.constant = 105
            recieveButtonBottomConstraint.constant = -120
            supplyButtonBottomConstraint.constant = -110
            supplyButtonRightConstraint.constant = -105
            borrowButtonBottomConstraint.constant = -90
            borrowButtonRightConstraint.constant = -35
        } else {
            stakeButtonBottomConstraint.constant = -30
            stakeButtonLeftConstraint.constant = centerX
            sendButtonBottomConstraint.constant = -30
            sendButtonLeftConstraint.constant = centerX
            recieveButtonBottomConstraint.constant = -30
            supplyButtonBottomConstraint.constant = -30
            supplyButtonRightConstraint.constant = -centerX
            borrowButtonBottomConstraint.constant = -30
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
        view.addAutolayoutSubviews(
            mockBackImageView,
            translucentView,
            infoLabel,
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
            mockBackImageView.topAnchor.constraint(equalTo: view.topAnchor),
            mockBackImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mockBackImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mockBackImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            translucentView.topAnchor.constraint(equalTo: view.topAnchor),
            translucentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            translucentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            translucentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            menuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            menuButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            menuButton.heightAnchor.constraint(equalToConstant: 80),
            menuButton.widthAnchor.constraint(equalToConstant: 80),
            
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: recieveButton.topAnchor, constant: -50),
            
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

