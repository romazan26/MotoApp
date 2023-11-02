//
//  LoginViewModel.swift
//  MotoApp
//
//  Created by Роман on 15.10.2023.
//

import Observation
import SwiftUI
import RealmSwift


final class LoginViewModel: ObservableObject {
    @Published var users = [User]()
    
    var currentUser: User!
    var authenticated = false
    
     var simpleUserName = ""
     var simplePassword = ""
    
    init() {
        
        let realm = try? Realm()
        
        if let users = realm?.objects(User.self) {
            self.users = Array(users)
            print("init ok")
        }else {
            try? realm?.write({
                let user = User()
                user.login = "Admin"
                user.password = "admin"
                realm?.add(user)
                print("add ok")
            })
            
            print("init no")}
        
    }
    
    var isLoginButtonDisable: Bool {
        simpleUserName.isEmpty || simplePassword.isEmpty
    }
    
    func login() {
//        for user in users {
//            if user.login == simpleUserName || user.password == simplePassword {
//                currentUser = user
//                authenticated.toggle()
//            }
//        }
//        print(users)
    }
    
    func logout() {
        toggleAuthentication()
    }
    private func toggleAuthentication() {
        withAnimation {
            authenticated.toggle()
        }
    }
    
    func addNewUser() {
        let user = User()
        user.login = simpleUserName
        user.password = simplePassword
        
        let realm = try? Realm()
        
        try? realm?.write {
                users.append(user)
            realm?.add(users)
                print("add ok")
            }
        
    }
}
