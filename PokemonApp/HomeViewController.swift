//
//  HomeViewController.swift
//  PokemonApp
//
//  Created by daud daud on 18/03/25.
//

import UIKit
import XLPagerTabStrip

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Wellcome Home"

        // Do any additional setup after loading the view.
    }
    

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Home")
    }

}
