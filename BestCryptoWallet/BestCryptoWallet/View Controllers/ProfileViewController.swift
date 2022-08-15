//
//  ProfileViewController.swift
//  BestCryptoWallet
//
//  Created by Lyubov Menshikova on 28.07.2022.
//

import UIKit

class ProfileViewController: BackgroundViewController {
    
    private let logOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выйти", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(red: 53/255, green: 212/255, blue: 184/255, alpha: 0.6)
        button.addTarget(self, action: #selector(logOutButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Приветствуем в Best Crypto Wallet!"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont(name: "Damascus", size: 21)
        label.numberOfLines = 0
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(welcomeLabel)
        view.addSubview(logOutButton)
        setupLayout()
    }
    
    private func setupLayout() {
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logOutButton.widthAnchor.constraint(equalToConstant: 100),
            logOutButton.heightAnchor.constraint(equalToConstant: 40),
            logOutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logOutButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            welcomeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func logOutButtonPressed() {
        let loginViewController = LoginViewController(loginView: LoginView(), userData: UserData.getUserData())
        UserDefaults.standard.set(false, forKey: "Logged_in")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginViewController)
        UserDefaults.standard.removeObject(forKey: "selectedIndex")
    }


}
