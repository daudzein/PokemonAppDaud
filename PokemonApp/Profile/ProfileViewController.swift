//
//  ProfileViewController.swift
//  PokemonApp
//
//  Created by daud daud on 18/03/25.
//

import UIKit
import XLPagerTabStrip

class ProfileViewController: UIViewController, IndicatorInfoProvider {
    
    let nameLabel = UILabel()
    let genderLabel = UILabel()
    let logoutButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
        loadUserData()

        view.backgroundColor = .white
        title = "Profile"
    }
    

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Profile")
    }
    
    func setupUI() {
            nameLabel.textAlignment = .center
        genderLabel.textAlignment = .center

            logoutButton.setTitle("Logout", for: .normal)
            logoutButton.setTitleColor(.white, for: .normal)
            logoutButton.backgroundColor = .red
            logoutButton.layer.cornerRadius = 8
            logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)

            let stackView = UIStackView(arrangedSubviews: [nameLabel, genderLabel, logoutButton])
            stackView.axis = .vertical
            stackView.spacing = 16
            stackView.translatesAutoresizingMaskIntoConstraints = false

            view.addSubview(stackView)
            
            NSLayoutConstraint.activate([
                stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                
                logoutButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
    
    func loadUserData() {
            if let name = UserDefaults.standard.string(forKey: "loggedInUser"),
               let gender = UserDefaults.standard.string(forKey: "loggedInGender") {
                nameLabel.text = "User Name: \(name)"
                genderLabel.text = "Gender: \(gender)"
            } else {
                nameLabel.text = "User Name: Tidak tersedia"
                genderLabel.text = "Gender: Tidak tersedia"
            }
        }
    
    @objc func logoutTapped() {
            // Delete session
            UserDefaults.standard.removeObject(forKey: "loggedInUser")
            UserDefaults.standard.removeObject(forKey: "loggedGender")
            
        let loginVC = SigninPageViewController()
            let navController = UINavigationController(rootViewController: loginVC)
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(navController)
        }

}
