//
//  User.swift
//  MotoApp
//
//  Created by Роман on 15.10.2023.
//

import Foundation
import RealmSwift

final class User: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var login = ""
    @Persisted var password = ""
    @Persisted var garageName = ""
    @Persisted var name = ""
    @Persisted var serName = ""
    @Persisted var technics = List<Technic>()
    
    override class func primaryKey() -> String? {
        "id"
    }
}
final class Technic: Object {
    @Persisted var type = ""
    @Persisted var title = ""
    @Persisted var note = ""
}
