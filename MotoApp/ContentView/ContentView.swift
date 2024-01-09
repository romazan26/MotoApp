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
    @Environment(\.dismiss) var dismiss
    
    @State var selectedTab = "Гараж"
    
    let tabs = ["Гараж", "Профиль", "События"]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            NavigationStack {
                TabView(selection: $selectedTab) {
                    GarageView(viewmodel: GarageViewModel(user: user))
                        .tag("Гараж")
                    ProfileView(viewModel: ProfileViewModel(user: user))
                        .tag("Профиль")
                    
                    EventsView()
                        .tag("События")
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            dismiss()
                            viewModel.logout()
                        }, label: {
                            Text("Выход")
                        })
                    }
                }
            }
            HStack{
                ForEach(tabs, id: \.self) { tab in
                    TabBarItem(tab: tab, selected: $selectedTab)
                }
            }
        }
    }
}

//MARK: - Tabbar Item
struct TabBarItem: View{
    @State var tab: String
    @Binding var selected: String
    var body: some View{
        ZStack {
            Button(action: {
                selected = tab
            },
                   label: {
                Image(tab)
                    .resizable()
                    .frame(width: 20, height: 20)
                if selected == tab {
                    Text(tab)
                        .foregroundStyle(.black)
                }
                    
            })
        }
        .opacity(selected == tab ? 1 : 0.8)
        .padding(.vertical, 10)
        .padding(.horizontal, 30)
        .background(selected == tab ? .red : .gray)
        .clipShape(Capsule())
    }
}

#Preview {
    ContentView(user: DataManager.shared.createTempData())
}
