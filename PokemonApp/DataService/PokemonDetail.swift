//
//  PokemonDetail.swift
//  PokemonApp
//
//  Created by daud daud on 19/03/25.
//

import Foundation

struct PokemonDetail: Codable {
    let name: String
    let abilities: [AbilityEntry]
}

struct AbilityEntry: Codable {
    let ability: Ability
}

struct Ability: Codable {
    let name: String
}
