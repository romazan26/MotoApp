//
//  LoginView.swift
//  MotoApp
//
//  Created by Роман on 27.09.2023.
//

import SwiftUI
import RealmSwift

struct LoginView: View {
    //MARK: Propertys
    @ObservedObject var viewModel = LoginViewModel()
    @FocusState private var nameIsFocused: Bool
    
    //MARK: - Body
    var body: some View {
        
        ZStack {
            LinearGradient(
                colors: [.orange.opacity(0.7), .blue.opacity(0.7)],
                startPoint: .bottomLeading,
                endPoint: .topTrailing)
            .opacity(0.7)
            .ignoresSafeArea()
            
            VStack (spacing: 20){
                
                //MARK: - Hellow Label
                Image("moto")
                    .resizable()
                    .frame(width: 380, height: 220)
                    .offset(y: -30)
                Text("Добро пожаловать в Гараж")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .shadow(color: .blue, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/) ///Сделать моргающию надпись
                
                //MARK: - TextFieldGroup
                CustomTextFieldUIView(text: $viewModel.simpleUserName, placeHolder: "Login...", isSecuriti: false)
                CustomTextFieldUIView(text: $viewModel.simplePassword, placeHolder: "Pasword...", isSecuriti: true)
                
                //MARK: - LoginButton
                HStack {
                    Button(action: {
                        viewModel.login()
                        if !viewModel.authenticated {viewModel.showAlert.toggle()}
                    },
                           label: {
                        Text("Вход")
                            .foregroundStyle(.white)
                            .font(.title2)
                            .bold()
                    })
                    .alert(isPresented: $viewModel.showAlert, content: {
                        Alert(title: Text("Неправильный ПАРОЛЬ или ЛОГИН"), dismissButton: .cancel({
                            viewModel.simplePassword = ""
                            viewModel.simpleUserName = ""
                        }))
                        
                    })
                    .frame(width: 160, height: 60)
                    .background(LinearGradient(
                        colors: viewModel.isLoginButtonDisable
                        ?[.gray.opacity(0.6)]
                        :[.orange, .blue.opacity(0.9)],
                        startPoint: .bottomLeading,
                        endPoint: .topTrailing))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .disabled(viewModel.isLoginButtonDisable)
                    
                    
                    //MARK: - AddUserButton
                    ButtonView(action: {
                        viewModel.addNewUser()
                        
                    }, label: "Новый гараж")
                }
                //MARK: - ShowUsersButton
                Button("Show users") {
                    viewModel.ispresented.toggle()
                }
                .sheet(isPresented: $viewModel.ispresented) {
                    UsersListView()
                }
                .shadow(color: .blue, radius: 10)
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
    func customStyle() -> some View {
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
            colors: [.orange, .blue.opacity(0.9)],
            startPoint: .bottomLeading,
            endPoint: .topTrailing))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
