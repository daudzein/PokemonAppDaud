//
//  UserModel.swift
//  PokemonApp
//
//  Created by daud daud on 18/03/25.
//

import Foundation
import RealmSwift


class User: Object {
    @Persisted var username: String
    @Persisted var password: String
}
