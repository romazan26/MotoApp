//
//  ProfileView.swift
//  MotoApp
//
//  Created by Роман on 27.09.2023.
//

import SwiftUI
import RealmSwift

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        
        ZStack {
            Image("serii-kirpich-fon")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.5)
            VStack {
                Text(viewModel.garage)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .shadow(color: .blue, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .bold()
                Text("\(viewModel.userName) \(viewModel.userSerName)")
                    .font(.largeTitle)
                    .bold()
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                
                CustomTextFieldUIView(text: $viewModel.simpleUserName, placeHolder: "Имя")
                    .focused($isFocused)
                CustomTextFieldUIView(text: $viewModel.simpleUserSerName, placeHolder: "Фамилия")
                    .focused($isFocused)
                CustomTextFieldUIView(text: $viewModel.simplegarageName , placeHolder: "Название гаража")
                    .focused($isFocused)
                
                ButtonView(action: {
                    viewModel.update()
                }, label: "Изменить данные")
            }.padding()
        }.onTapGesture {
            isFocused = false
        }
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel(user: DataManager.shared.createTempData()))
}
