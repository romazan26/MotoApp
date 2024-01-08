//
//  GarageViewModel.swift
//  MotoApp
//
//  Created by Роман on 08.01.2024.
//

import Foundation
import RealmSwift


final class GarageViewModel: ObservableObject {
    
    @ObservedRealmObject var user: User
    
    init(user: User) {
        self.user = user
    }
    var technics: List<Technic> {
        user.technics
    }
    var garage: String {
        user.garageName
    }
    
    @Published var typeTehnic = ""
    @Published var titleTehnic = ""
    @Published var noteTehnic = ""
    
    
    //MARK: - addTechnic function
     func addTehnic() {
        let tehnic = Technic()
        tehnic.type = typeTehnic
        tehnic.title = titleTehnic
        tehnic.note = noteTehnic
        
        $user.technics.append(tehnic)
        typeTehnic = ""
        titleTehnic = ""
        
    }
    
}
