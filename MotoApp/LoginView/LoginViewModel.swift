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
    @ObservedResults(User.self) var users
    @Published var authenticated = false
    @Published var simpleUserName = ""
    @Published var simplePassword = ""
    @Published var currentUser: User!
    
    var isLoginButtonDisable: Bool {
        simpleUserName.isEmpty || simplePassword.isEmpty
    }
//MARK: - Login
    func login() {
        for user in users {
            if user.login == simpleUserName || user.password == simplePassword {
                currentUser = user
                toggleAuthentication()
            }
        }
    }
//MARK: - Logout
    func logout() {
        toggleAuthentication()
        simplePassword = ""
        simpleUserName = ""
    }
    
    private func toggleAuthentication() {
        withAnimation {
            authenticated.toggle()
        }
    }
    
 //MARK: - AddNewUser
    func addNewUser() {
        let user = User()
        user.login = simpleUserName
        user.password = simplePassword
        
        $users.append(user)
    }
}
