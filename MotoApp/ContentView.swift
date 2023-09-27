//
//  ContentView.swift
//  MotoApp
//
//  Created by Роман on 27.09.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
           GarageView()
                .tabItem {
                    Image("door.garage.double.bay.closed")
                    Text("Гараж")
                }
            ProfileView()
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

#Preview {
    ContentView()
}
