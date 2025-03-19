//
//  PokemonListResponse.swift
//  PokemonApp
//
//  Created by daud daud on 19/03/25.
//

import Foundation

struct PokemonListResponse: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let url: String
}
