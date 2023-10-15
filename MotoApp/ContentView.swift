//
//  ContentView.swift
//  MotoApp
//
//  Created by Роман on 27.09.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = LoginViewModel()
    var body: some View {
        if !viewModel.authenticated {
            LoginView(viewModel: viewModel)
        } else {
            TabView {
                GarageView()
                    .tabItem {
                        Image("door.garage.closed")
                        Text("Гараж")
                    }
                ProfileView(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: "person")
                        Text("Профиль")
                    }
                EventsView()
                    .tabItem {
                        Image(systemName: "exclamationmark.bubble.fill")
                        Text("События")
                    }
            }
        }
    }
}
#Preview {
    ContentView()
}
