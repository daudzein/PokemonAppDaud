//
//  SignupViewController.swift
//  PokemonApp
//
//  Created by daud daud on 18/03/25.
//

import UIKit

class SignupViewController: UIViewController {
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
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
        registerButton.setTitle("Register", for: .normal)

        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField, registerButton])
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

    @objc func registerTapped() {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Username dan Password tidak boleh kosong")
            return
        }

        if DatabaseManager.shared.registerUser(username: username, password: password) {
            showAlert(message: "Registrasi berhasil! Silakan login.", completion: {
                self.dismiss(animated: true)
            })
        } else {
            showAlert(message: "Username sudah digunakan")
        }
    }

    func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        present(alert, animated: true)
    }
}
