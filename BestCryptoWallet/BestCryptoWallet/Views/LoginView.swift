//
//  LoginView.swift
//  BestCryptoWallet
//
//  Created by Lyubov Menshikova on 24.07.2022.
//

import UIKit

class LoginView: UIView {
    
    var loginAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray6
        setupHorizontalStackView()
        
        addSubview(greetingLabel)
        addSubview(instructionLabel)
        setupVerticalStackView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "png-3")
        return imageView
    }()
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Best Crypto Wallet"
        label.numberOfLines = 0
        label.font = UIFont(name: "DamascusBold", size: 23)
        label.textAlignment = .center
        return label
    }()
    
    let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        
        return stackView
    }()
    
    let greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Добро пожаловать!"
        label.font = UIFont(name: "DamascusBold", size: 22)
        label.textAlignment = .center
        return label
    }()
    
    let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Пожалуйста введите логин и пароль"
        label.font = UIFont(name: "Damascus", size:18)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let loginTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .white
        
        textField.placeholder = "Login"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .white
        
        textField.placeholder = "Password"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(red: 53/255, green: 212/255, blue: 184/255, alpha: 0.6)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        
        return stackView
    }()
    
    private func setupHorizontalStackView() {
        horizontalStackView.addArrangedSubview(iconView)
        horizontalStackView.addArrangedSubview(appNameLabel)
        addSubview(horizontalStackView)
    }
     
    private func setupVerticalStackView() {
        verticalStackView.addArrangedSubview(loginTextField)
        verticalStackView.addArrangedSubview(passwordTextField)
        verticalStackView.addArrangedSubview(loginButton)
        addSubview(verticalStackView)
    }
    
    private func setupLayout() {
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            iconView.widthAnchor.constraint(equalToConstant: 55),
            iconView.heightAnchor.constraint(equalToConstant: 55),
            appNameLabel.widthAnchor.constraint(equalToConstant: 150),
            appNameLabel.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            verticalStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 35),
            loginTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            greetingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            greetingLabel.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 40),
            greetingLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            instructionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            instructionLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 10),
            instructionLabel.heightAnchor.constraint(equalToConstant: 50),
            instructionLabel.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    @objc func loginButtonPressed() {
        loginAction?()
    }
    
   
}
