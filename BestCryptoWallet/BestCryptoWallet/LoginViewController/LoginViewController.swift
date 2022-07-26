//
//  LoginViewController.swift
//  BestCryptoWallet
//
//  Created by Lyubov Menshikova on 24.07.2022.
//

import UIKit
import Combine

final class LoginViewController: UIViewController {
    
    var loginView: LoginView
    var viewModel: LoginViewModel?
    var login: String?
    var password: String?
    private var cancellables: Set<AnyCancellable> = []
    
    init(loginView: LoginView) {
        self.loginView = loginView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addConstraints()
        viewModel?.getUserData()
        self.loginView.loginAction = loginPressed
        loginView.loginTextField.delegate = self
        loginView.passwordTextField.delegate = self
       
    }
    
    
    private func addConstraints() {
        view.addSubview(loginView)
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func loginPressed() {
        guard let viewModel = viewModel else { return }
        viewModel.$login.sink { [weak self] login in
            guard let self = self else { return }
            self.login = login
        }.store(in: &cancellables)
        viewModel.$password.sink { [weak self] password in
            guard let self = self else { return }
            self.password = password
        }.store(in: &cancellables)
        guard
            self.loginView.loginTextField.text == login,
            self.loginView.passwordTextField.text == password else {
                self.showAlert(title: "Неверный логин или пароль", message: "Пожалуйста, введите корректные данные")
                return
            }
        let mainTabBarController = MainTabBarController()
        UserDefaults.standard.set(true, forKey: "Logged_in")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    }
}

//MARK: Alert
extension LoginViewController {
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "OK",
                                        style: .cancel,
                                        handler: { [weak self] _ in
            guard let self = self else {return}
            self.loginView.loginTextField.text = nil
            self.loginView.passwordTextField.text = nil
        })
        alertController.addAction(closeAction)
        present(alertController, animated: true, completion: nil)
    }
}

//MARK: TextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //keyboard disappears after pressing view
        self.view.endEditing(true)
        loginView.loginTextField.text = nil
        loginView.passwordTextField.text = nil
    }
    
    // pressing enter after login. in viewDidLoad sets delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginView.loginTextField {
            loginView.passwordTextField.becomeFirstResponder()
        } else {
            loginPressed()
        }
        return true
    }
    
}
