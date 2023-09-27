//
//  LoginView.swift
//  MotoApp
//
//  Created by Роман on 27.09.2023.
//

import SwiftUI

struct LoginView: View {
    @State private var login = ""
    @State private var password = ""
    @State private var isPresented = false
    @FocusState private var nameIsFocused: Bool
    
    var body: some View {
       
        VStack (spacing: 20){
            Image("moto")
                .resizable()
                .frame(width: 380, height: 220)
                .offset(y: -30)
            Text("Добро пожаловать")
                .font(.largeTitle)
                .shadow(radius: 5)
            TextField("login...", text: $login)
                .textFieldStyle(.roundedBorder)
                .border(.black)
                .focused($nameIsFocused)
            TextField("password...", text: $password)
                .textFieldStyle(.roundedBorder)
                .border(.black)
                .focused($nameIsFocused)
            
            HStack {
                Button("Login", action: {
                    isPresented.toggle()
                }
                ).sheet(isPresented: $isPresented, content: {
                    ContentView()
                })
                    .buttonStyle(.borderedProminent)
                Button("Create new user", action: {})
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .onTapGesture {
            nameIsFocused = false
        }
    }
}

#Preview {
    LoginView()
}
