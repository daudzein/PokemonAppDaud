//
//  DatabaseManager.swift
//  PokemonApp
//
//  Created by daud daud on 18/03/25.
//

import RealmSwift


class DatabaseManager {
    static let shared = DatabaseManager()
    private let realm = try! Realm()

    // Simpan user ke database (Registrasi)
    func registerUser(username: String, password: String) -> Bool {
        if isUserExists(username: username) {
            return false // User sudah ada
        }

        let user = User()
        user.username = username
        user.password = password

        try! realm.write {
            realm.add(user)
        }
        return true
    }

    // Cek apakah user sudah terdaftar
    func isUserExists(username: String) -> Bool {
        return realm.objects(User.self).filter("username == %@", username).first != nil
    }

    // Cek login user
    func loginUser(username: String, password: String) -> Bool {
        return realm.objects(User.self).filter("username == %@ AND password == %@", username, password).first != nil
    }
}
