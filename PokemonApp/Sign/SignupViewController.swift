//
//  SignupViewController.swift
//  PokemonApp
//
//  Created by daud daud on 18/03/25.
//

import UIKit

class SignupViewController: UIViewController {
    let usernameTextField = UITextField()
    let genderTextField = UITextField()
    let passwordTextField = UITextField()
    let signUpButton = UIButton(type: .system)
    let signInButton = UIButton(type: .system)
    
    let genderPickerView = UIPickerView()
    let genderOptions = ["Laki-laki", "Perempuan", "Lainnya"]
    var selectedGender = "Laki-laki"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        
        genderTextField.inputView = genderPickerView
        genderTextField.inputAccessoryView = createToolbar()

        setupUI()
    }

    func setupUI() {
        usernameTextField.placeholder = "Username / Email"
        genderTextField.placeholder = "Gender"
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        signUpButton.setTitle("Sign Up", for: .normal)
        signInButton.setTitle("Sign In", for: .normal)

        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [usernameTextField, genderTextField, passwordTextField, signUpButton, signInButton])
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

    @objc func signUpTapped() {
        guard let username = usernameTextField.text, !username.isEmpty,
              let gender = genderTextField.text, !gender.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Username dan Password tidak boleh kosong")
            return
        }

        if DatabaseManager.shared.registerUser(username: username, gender: self.selectedGender, password: password) {
            //add to session
            UserDefaults.standard.set(username, forKey: "loggedInUser")
            UserDefaults.standard.set(gender, forKey: "loggedInGender")
            
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
    
    @objc func signInTapped() {
        usernameTextField.text = ""
        genderTextField.text = ""
        passwordTextField.text = ""
        
        let registerVC = SigninPageViewController()
        let navVC = UINavigationController(rootViewController: registerVC)
        navVC.modalPresentationStyle = .overCurrentContext
        present(navVC, animated: true)
    }
}

extension SignupViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGender = genderOptions[row]
        genderTextField.text = selectedGender
    }
    
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPicker))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        return toolbar
    }
    
    @objc func dismissPicker() {
        view.endEditing(true)
    }
}
