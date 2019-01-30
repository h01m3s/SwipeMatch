//
//  RegistrationController.swift
//  SwipeMatch
//
//  Created by Weijie Lin on 1/30/19.
//  Copyright © 2019 Weijie Lin. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {
    
    // UI Components
    let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 275).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    let fullNameTextField: CustomTextField = {
        let textField = CustomTextField(padding: 16)
        textField.placeholder = "Enter full name"
        return textField
    }()

    let emailTextField: CustomTextField = {
        let textField = CustomTextField(padding: 16)
        textField.placeholder = "Enter email"
        return textField
    }()
    
    let passwordTextField: CustomTextField = {
        let textField = CustomTextField(padding: 16)
        textField.placeholder = "Enter password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.backgroundColor = #colorLiteral(red: 0.8287895322, green: 0.09591957182, blue: 0.3255727291, alpha: 1)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.layer.cornerRadius = 22
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupGradientLayer()
        
        setupLayout()
        
        setupNotificationObservers()
        
        setupTapGesture()
    }
    
    // MARK:- Private
    
    fileprivate func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    @objc fileprivate func handleTapDismiss() {
        self.view.endEditing(true) // dismisses keyboard
    }
    
    fileprivate func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // will have retain cycle if don't remove observer
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc fileprivate func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        })
    }
    
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
//        print("Keyboard will show")
//        print(notification.userInfo)
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
//        print(keyboardFrame)
//        (x, y, width, height)
//        (0.0, 521.0, 375.0, 291.0)
        
        // Find the gap is from the register button to the bottom of the screen
        let bottomSpace = view.frame.height - stackView.frame.origin.y - stackView.frame.height
//        print(bottomSpace)
        
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
    }
    
    lazy var stackView = UIStackView(arrangedSubviews: [
        selectPhotoButton,
        fullNameTextField,
        emailTextField,
        passwordTextField,
        registerButton
        ])
    
    fileprivate func setupLayout() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        let topColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
    
}
