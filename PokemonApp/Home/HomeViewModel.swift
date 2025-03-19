//
//  HomeViewModel.swift
//  PokemonApp
//
//  Created by daud daud on 19/03/25.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class HomeViewModel {
    private let disposeBag = DisposeBag()
    
    let pokemonList = PublishSubject<[Pokemon]>()
    let pokemonDetail = PublishSubject<PokemonDetail>()
    let errorMessage = PublishSubject<String>()
    
    func fetchPokemons(limit: Int = 10, offset: Int = 0) {
        PokemonService.shared.fetchPokemonList(limit: limit, offset: offset)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { pokemons in
                self.pokemonList.onNext(pokemons)
            }, onError: { error in
                self.errorMessage.onNext("Gagal memuat data Pokémon: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
    
    func fetchPokemonDetail(name: String) {
        PokemonService.shared.fetchPokemonDetail(pokemonName: name)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { detail in
                self.pokemonDetail.onNext(detail)
            }, onError: { error in
                self.errorMessage.onNext("Gagal memuat detail Pokémon: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
}
