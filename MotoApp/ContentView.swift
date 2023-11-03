//
//  ContentView.swift
//  MotoApp
//
//  Created by Роман on 27.09.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = LoginViewModel()
    var body: some View {
        if !viewModel.authenticated {
            LoginView(viewModel: viewModel)
        } else {
            NavigationStack {
                TabView {
                    GarageView()
                        .tabItem {
                            Image("door.garage.closed")
                            Text("Гараж")
                        }
                    ProfileView(user: viewModel.currentUser)
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
                .navigationTitle("User")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {viewModel.logout()}, label: {
                            Text("LogOut")
                        })
                    }
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
