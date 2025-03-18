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
    let loginButton = UIButton(type: .system)
    let registerButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
    }

    func setupUI() {
        usernameTextField.placeholder = "Username"
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        loginButton.setTitle("Login", for: .normal)
        registerButton.setTitle("Register", for: .normal)

        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField, loginButton, registerButton])
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

    @objc func loginTapped() {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Username dan Password tidak boleh kosong")
            return
        }

        if DatabaseManager.shared.loginUser(username: username, password: password) {
            // Simpan sesi user
            UserDefaults.standard.set(username, forKey: "loggedInUser")
            UserDefaults.standard.synchronize()

            let homeVC = MainTabController()
            let navVC = UINavigationController(rootViewController: homeVC)
            navVC.modalPresentationStyle = .overCurrentContext
            present(navVC, animated: true)
        } else {
            showAlert(message: "Username atau Password salah")
        }
    }

    @objc func registerTapped() {
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
