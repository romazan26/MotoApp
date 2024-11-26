//
//  HellowView.swift
//  MotoApp
//
//  Created by Роман on 18.01.2024.
//

import SwiftUI

struct HellowView: View {
    @ObservedObject var viewModel = LoginViewModel()
    @State private var isPresent: Bool = false
    
    var body: some View {
        VStack{
            Image(.moto)
                .resizable()
                .frame(width: 380, height: 220)
                .offset(y: -30)
                .shadow(color: .orange, radius: 5)
            
            Text("Добро пожаловать в гараж!").font(.title)
                .shadow(color: .orange, radius: 1)
               
        }
        .onAppear(perform: {
            viewModel.login()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isPresent = true
            }
        })
        .fullScreenCover(isPresented: $isPresent, content: {
            GarageView(viewmodel: GarageViewModel(user: viewModel.currentUser), viewModelLogin: viewModel)
        })
    }
}

#Preview {
    HellowView()
}
