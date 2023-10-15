//
//  ProfileView.swift
//  MotoApp
//
//  Created by Роман on 27.09.2023.
//

import SwiftUI

struct ProfileView: View {
    @Bindable var viewModel: LoginViewModel
    var body: some View {
        VStack {
            Text("User: \(viewModel.user.name)")
            Image(systemName: "person")
                .resizable()
                .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    ProfileView(viewModel: LoginViewModel())
}
