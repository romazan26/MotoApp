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
            Text("Добро пожаловать в Гараж")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .shadow(radius: 5)
            TextField("login...", text: $login)
                .costomStyle()
                .focused($nameIsFocused)
            SecureField("password...", text: $password)
                .costomStyle()
                .focused($nameIsFocused)
            
            HStack {
                Button(action: { isPresented.toggle()},
                       label: {
                    Text("Вход")
                        .foregroundStyle(.white)
                        .font(.title2)
                        .bold()
                })
                .frame(width: 160, height: 60)
                .background(LinearGradient(
                    colors: [.black, .blue.opacity(0.5)],
                    startPoint: .bottomLeading,
                    endPoint: .topTrailing))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .sheet(isPresented: $isPresented, content: {
                    ContentView()
                })
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Новый Гараж")
                        .foregroundStyle(.white)
                        .font(.title2)
                        .bold()
                })
                .frame(width: 160, height: 60)
                .background(LinearGradient(
                    colors: [.black, .blue.opacity(0.5)],
                    startPoint: .bottomLeading,
                    endPoint: .topTrailing))
                .clipShape(RoundedRectangle(cornerRadius: 15))
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

struct TFStyleViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: 320)
            .background(.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

extension View {
    func costomStyle() -> some View {
        modifier(TFStyleViewModifier())
    }
}
