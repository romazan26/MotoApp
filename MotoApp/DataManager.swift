//
//  DataManager.swift
//  MotoApp
//
//  Created by Роман on 17.10.2023.
//

import Foundation

final class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    func createTempData() -> User {
        let user = User()
        user.garageName = "Home"
        user.name = "Roman"
        user.serName = "Glavackii"
        
        let moto = Technic()
        moto.type = "motocycle"
        moto.title = "KTM"
        moto.note = "250cc"
        
        user.technics.append(moto)
        return user
       
    }
}
