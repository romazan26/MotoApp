//
//  LoginViewModel.swift
//  MotoApp
//
//  Created by Роман on 15.10.2023.
//

import Observation
import SwiftUI

@Observable
final class LoginViewModel {
    var user = User()
    var authenticated = false
    
    private var sampleUserName = "Username"
    private var samplePassword = "Password"
    
    var isLoginButtonDisable: Bool {
        user.name.isEmpty || user.password.isEmpty
    }
    
    func login() {
        guard user.name == sampleUserName, user.password == samplePassword else {
            return
        }
       toggleAuthentication()
    }
    
    func logout() {
        user.name = ""
        user.password = ""
        toggleAuthentication()
    }
    private func toggleAuthentication() {
        withAnimation {
            authenticated.toggle()
        }
    }
}
