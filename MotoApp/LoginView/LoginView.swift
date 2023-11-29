//
//  LoginView.swift
//  MotoApp
//
//  Created by Роман on 27.09.2023.
//

import SwiftUI
import RealmSwift

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    @FocusState private var nameIsFocused: Bool
    @State private var ispresented = false
    @State private var showAlert = false
    
    //MARK: - Body
    var body: some View {
        
        ZStack {
            Image("serii-kirpich-fon")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.5)
            VStack (spacing: 20){
                
                //MARK: - ShowUsersButton
                Button("Show users") {
                    ispresented.toggle()
                }
                .sheet(isPresented: $ispresented) {
                    UsersListView()
                }
                .shadow(color: .blue, radius: 10)
                
                //MARK: - Hellow Label
                Image("moto")
                    .resizable()
                    .frame(width: 380, height: 220)
                    .offset(y: -30)
                Text("Добро пожаловать в Гараж")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .shadow(radius: 5)
                
                //MARK: - TextFieldGroup
                TextField("Login...", text: $viewModel.simpleUserName)
                    .costomStyle()
                    .focused($nameIsFocused)
                SecureField("Pasword...", text: $viewModel.simplePassword)
                    .costomStyle()
                    .focused($nameIsFocused)
                
                
                HStack {
                    
                    //MARK: - LoginButton
                    Button(action: {
                        viewModel.login()
                        if !viewModel.authenticated {showAlert.toggle()}
                    },
                           label: {
                        Text("Вход")
                            .foregroundStyle(.white)
                            .font(.title2)
                            .bold()
                    })
                    .alert(isPresented: $showAlert, content: {
                        Alert(title: Text("Неправильный ПАРОЛЬ или ЛОГИН"), dismissButton: .cancel({
                            viewModel.simplePassword = ""
                            viewModel.simpleUserName = ""
                        }))
                        
                    })
                    .sheet(isPresented: $viewModel.authenticated, content: {
                        ContentView(user: viewModel.currentUser)
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
                    
                    
                    //MARK: - AddUserButton
                    ButtonView(action: {
                        viewModel.addNewUser()
                        
                    }, label: "Новый пользователь")
                }
            }
            .padding()
            .onTapGesture {
                nameIsFocused = false
            }
        }
    }
}

//MARK: - Preview
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
