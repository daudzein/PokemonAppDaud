//
//  MainTabController.swift
//  PokemonApp
//
//  Created by daud daud on 18/03/25.
//

import Foundation
import UIKit
import XLPagerTabStrip

class MainTabController: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Konfigurasi UI
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.buttonBarItemTitleColor = .black
        settings.style.selectedBarBackgroundColor = .blue
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 16)
        settings.style.buttonBarHeight = 50
        
        self.moveTabBarToBottom()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let homeVC = HomeViewController()
        let profileVC = ProfileViewController()
        return [homeVC, profileVC]
    }
    
    private func moveTabBarToBottom() {
            guard let buttonBarView = self.buttonBarView else { return }

            buttonBarView.removeFromSuperview()
            
            buttonBarView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(buttonBarView)

            NSLayoutConstraint.activate([
                buttonBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                buttonBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                buttonBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                buttonBarView.heightAnchor.constraint(equalToConstant: 50)
            ])
            
            containerView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                containerView.bottomAnchor.constraint(equalTo: buttonBarView.topAnchor)
            ])
        }
}
