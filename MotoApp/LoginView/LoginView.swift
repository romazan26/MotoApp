//
//  LoginView.swift
//  MotoApp
//
//  Created by Роман on 27.09.2023.
//

import SwiftUI
import RealmSwift

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    @FocusState private var nameIsFocused: Bool
    
    var body: some View {
        
        ZStack {
            Image("serii-kirpich-fon")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.5)
            VStack (spacing: 20){
                Button("show users") {
                    print("\(viewModel.users) \(viewModel.simpleUserName)")
                }
                Image("moto")
                    .resizable()
                    .frame(width: 380, height: 220)
                    .offset(y: -30)
                Text("Добро пожаловать в Гараж")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .shadow(radius: 5)
                
                TextField("login...", text: $viewModel.simpleUserName)
                    .costomStyle()
                    .focused($nameIsFocused)
                SecureField("password...", text: $viewModel.simplePassword)
                    .costomStyle()
                    .focused($nameIsFocused)
                
                HStack {
                    Button(action: { viewModel.login()},
                           label: {
                        Text("Вход")
                            .foregroundStyle(.white)
                            .font(.title2)
                            .bold()
                    })
                    .frame(width: 160, height: 60)
                    .background(LinearGradient(
                        colors: viewModel.isLoginButtonDisable
                        ?[.gray.opacity(0.6)]
                        :[.black, .blue.opacity(0.5)],
                        startPoint: .bottomLeading,
                        endPoint: .topTrailing))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .disabled(viewModel.isLoginButtonDisable)
                    
                    ButtonView(action: {
                        viewModel.addNewUser()
                    }, label: "Новый Гараж")
                }
            }
            .padding()
            .onTapGesture {
                nameIsFocused = false
        }
        }
    }
}


#Preview {
    LoginView(viewModel: LoginViewModel())
}

struct TFStyleViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: 320)
            .background(.gray.opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

extension View {
    func costomStyle() -> some View {
        modifier(TFStyleViewModifier())
    }
}

struct ButtonView: View {
    let action: () -> Void
    let label: String
    var body: some View {
        Button(action: action, label: {
            Text(label)
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
