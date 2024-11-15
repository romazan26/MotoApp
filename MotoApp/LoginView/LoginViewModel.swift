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
    
    @AppStorage("isLogin") var isLogin: Bool?
    @AppStorage("userName") var name: String?
    @AppStorage("userPassword") var password: String?
    @AppStorage("coreDataActive") var coreDataActive: Bool?
    
    @Published var authenticated = false
    @Published var simpleUserName = ""
    @Published var simplePassword = ""
    @Published var garageName = ""
    @Published var currentUser: User!
    @Published var ispresented = false
    @Published var showAlert = false
    @Published var isPresentedAlert = false
    
    init() {
        if users.isEmpty{
            coreDataActive = true
        }
        if ((name?.isEmpty) != nil){
            simpleUserName = name ?? ""
        }
        if ((password?.isEmpty) != nil) {
            simplePassword = password ?? ""
        }
        if isLogin == false {
            authenticated = isLogin ?? false
        }
    }
    
    var isLoginButtonDisable: Bool {
        simpleUserName.isEmpty || simplePassword.isEmpty
    }
    
//MARK: - Login
    func login() {
        for user in users {
            if user.login == simpleUserName && user.password == simplePassword {
                currentUser = user
                toggleAuthentication()
                name = simpleUserName
                password = simplePassword
                isLogin = true
            }
        }
    }
//MARK: - Logout
    func logout() {
        toggleAuthentication()
        isLogin = false
        simplePassword = ""
        simpleUserName = ""
        name = ""
        password = ""
        currentUser = nil
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
        user.garageName = garageName
        
        $users.append(user)
    }
}
