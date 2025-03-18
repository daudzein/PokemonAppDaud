//
//  ProfileViewController.swift
//  PokemonApp
//
//  Created by daud daud on 18/03/25.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Profile"
        
        let username = UserDefaults.standard.string(forKey: "loggedInUser") ?? "Guest"
                
        let label = UILabel()
        label.text = "Welcome, \(username)"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Profile")
    }

}
