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
    
    func createTempDataTechic() -> Technic {
       
        let moto = Technic()
        moto.type = "motocycle"
        moto.title = "KTM"
        moto.note = "250cc"
        
        let work = Work()
        work.nameWork = "change Oil"
        work.odometr = 100
        work.price = 1200
        work.date = Date.now
        
        moto.works.append(work)
        return moto
       
    }
}
