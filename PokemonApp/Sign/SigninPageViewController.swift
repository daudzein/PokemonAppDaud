//
//  SigninPageViewController.swift
//  PokemonApp
//
//  Created by daud daud on 18/03/25.
//

import UIKit

class SigninPageViewController: UIViewController {
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let signUpButton = UIButton(type: .system)
    let signInButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
    }

    func setupUI() {
        usernameTextField.placeholder = "Username"
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        signInButton.setTitle("Sign In", for: .normal)
        signUpButton.setTitle("Sign Up", for: .normal)

        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField, signInButton, signUpButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.widthAnchor.constraint(equalToConstant: 250)
        ])
    }

    @objc func signInTapped() {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Username dan Password tidak boleh kosong")
            return
        }
        
        if DatabaseManager.shared.loginUser(username: username, password: password) {
                UserDefaults.standard.set(username, forKey: "loggedInUser")
                UserDefaults.standard.set(username, forKey: "loggedInUser")
                UserDefaults.standard.synchronize()

                let mainTabController = MainTabController()
                mainTabController.modalPresentationStyle = .fullScreen
                present(mainTabController, animated: true)
            } else {
                showAlert(message: "Username atau Password salah")
            }
    }

    @objc func signUpTapped() {
        usernameTextField.text = ""
        passwordTextField.text = ""
        
        let registerVC = SignupViewController()
        let navVC = UINavigationController(rootViewController: registerVC)
        navVC.modalPresentationStyle = .overCurrentContext
        present(navVC, animated: true)
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
