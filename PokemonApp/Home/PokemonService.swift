//
//  PokemonService.swift
//  PokemonApp
//
//  Created by daud daud on 19/03/25.
//

import Alamofire
import RxSwift

class PokemonService {
    static let shared = PokemonService()
    private let baseURL = "https://pokeapi.co/api/v2/"
    
    func fetchPokemonList(limit: Int = 10, offset: Int = 0) -> Observable<[Pokemon]> {
        let url = "\(baseURL)pokemon?limit=\(limit)&offset=\(offset)"
        
        return Observable.create { observer in
            AF.request(url)
                .validate()
                .responseDecodable(of: PokemonListResponse.self) { response in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(data.results)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    
    func fetchPokemonDetail(pokemonName: String) -> Observable<PokemonDetail> {
        let url = "\(baseURL)pokemon/\(pokemonName)"
        
        return Observable.create { observer in
            AF.request(url)
                .validate()
                .responseDecodable(of: PokemonDetail.self) { response in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(data)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}
