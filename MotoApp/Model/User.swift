//
//  User.swift
//  MotoApp
//
//  Created by Роман on 15.10.2023.
//

import Foundation
import RealmSwift

final class User: Object {
    @Persisted var name = ""
    @Persisted var password = ""
    @Persisted var garageName = ""
    @Persisted var technics = List<Technic>()
}
final class Technic: Object {
    @Persisted var type = ""
    @Persisted var title = ""
    @Persisted var note = ""
}
