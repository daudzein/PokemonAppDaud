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
        // Konfigurasi UI
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.buttonBarItemTitleColor = .black
        settings.style.selectedBarBackgroundColor = .blue
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 16)
        settings.style.buttonBarHeight = 50

        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let homeVC = HomeViewController()
        let profileVC = ProfileViewController()
        return [homeVC, profileVC]
    }
}
