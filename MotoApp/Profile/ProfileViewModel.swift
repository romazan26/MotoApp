//
//  ProfileViewModel.swift
//  MotoApp
//
//  Created by Роман on 02.11.2023.
//

import Foundation
import RealmSwift
import SwiftUI

final class ProfileViewModel: ObservableObject {
    
    @Published var simpleUserName = ""
    @Published var simpleUserSerName = ""
    @Published var simplegarageName = ""
    
    			
    var userName: String {
        user.name
    }
    var userSerName: String {
        user.serName
    }
    var garage: String {
        user.garageName
    }
    
    private var user: User
    
    init(user: User) {
        self.user = user
    }
    
    //MARK: - update fnction
        func update() {
            do{
                let realm = try Realm()
                guard let objecttoupdate = realm.object(ofType: User.self, forPrimaryKey: user.id) else {
                    return
                }
                try realm.write {
                    if !simpleUserName.isEmpty
                    {objecttoupdate.name = simpleUserName}
                    if !simpleUserSerName.isEmpty
                    {objecttoupdate.serName = simpleUserSerName}
                    if !simplegarageName.isEmpty
                    {objecttoupdate.garageName = simplegarageName}
                }
                user = objecttoupdate
            }catch{print(error)}
            
            simpleUserName = ""
            simpleUserSerName = ""
            simplegarageName = ""
        }
}
