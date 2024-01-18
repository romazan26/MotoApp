//
//  MotoAppApp.swift
//  MotoApp
//
//  Created by Роман on 27.09.2023.
//

import SwiftUI

@main
struct MotoAppApp: App {
    
    @AppStorage("isLogin") var isLogin: Bool = false

    var body: some Scene {
        WindowGroup {
            if isLogin {
                HellowView()
            }else {
                LoginView()
            }
        }
    }
}
