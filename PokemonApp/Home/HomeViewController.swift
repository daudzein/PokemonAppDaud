//
//  HomeViewController.swift
//  PokemonApp
//
//  Created by daud daud on 18/03/25.
//

import UIKit
import XLPagerTabStrip
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, IndicatorInfoProvider, UITableViewDelegate {
    var window: UIWindow?
    
    let tableView = UITableView()
    let viewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    
    var pokemons: [Pokemon] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.fetchPokemons()
        bindViewModel()
        
        
        let navigationController = UINavigationController(rootViewController: HomeViewController())
        window?.rootViewController = navigationController
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.isUserInteractionEnabled = true
        tableView.allowsSelection = true
    }

    func bindViewModel() {
        // Pastikan `rx.items` digunakan sebelum `rx.modelSelected`
        viewModel.pokemonList
            .bind(to: tableView.rx.items(cellIdentifier: "cell")) { _, pokemon, cell in
                cell.textLabel?.text = pokemon.name.capitalized
            }
            .disposed(by: disposeBag)

        // selected item
        tableView.rx.modelSelected(Pokemon.self)
            .subscribe(onNext: { [weak self] selectedPokemon in
                print("Selected Pokémon: \(selectedPokemon.name)")
                let detailVC = DetailViewController(pokemonName: selectedPokemon.name)
                self?.navigationController?.pushViewController(detailVC, animated: true)
                print("Navigation Controller: \(String(describing: self?.navigationController))")
            })
            .disposed(by: disposeBag)
        
        // Handle error jika gagal fetch data
        viewModel.errorMessage
        .subscribe(onNext: { error in
            print(error)
        })
        .disposed(by: disposeBag)
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Home")
    }
}
