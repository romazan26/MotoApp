//
//  ContentView.swift
//  MotoApp
//
//  Created by Роман on 27.09.2023.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @ObservedObject var viewModel = LoginViewModel()
    @ObservedRealmObject var user: User
    
    var body: some View {
            NavigationStack {
                TabView {
                    GarageView(user: user)
                        .tabItem {
                            Image("door.garage.closed")
                            Text("Гараж")
                        }
                    ProfileView(user: user)
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
                        Button(action: {print(user)}, label: {
                            Text("LogOut")
                        })
                    }
                }
            }
        }
    }

#Preview {
    ContentView( user: User())
}
