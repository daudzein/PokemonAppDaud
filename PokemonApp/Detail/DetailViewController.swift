//
//  DetailViewController.swift
//  PokemonApp
//
//  Created by daud daud on 19/03/25.
//

import UIKit
import RxSwift


class DetailViewController: UIViewController {
    
    let viewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    
    let nameLabel = UILabel()
    let abilitiesLabel = UILabel()
    
    let pokemonName: String
    
    init(pokemonName: String) {
        self.pokemonName = pokemonName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = pokemonName.capitalized
        
        setupUI()
        bindViewModel()
        viewModel.fetchPokemonDetail(name: pokemonName)
    }
    
    func setupUI() {
        nameLabel.textAlignment = .center
        abilitiesLabel.textAlignment = .center
        abilitiesLabel.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, abilitiesLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func bindViewModel() {
        viewModel.pokemonDetail
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] detail in
                self?.nameLabel.text = "Nama: \(detail.name.capitalized)"
                self?.abilitiesLabel.text = "Abilities: \(detail.abilities.map { $0.ability.name.capitalized }.joined(separator: ", "))"
            })
            .disposed(by: disposeBag)
    }
}
