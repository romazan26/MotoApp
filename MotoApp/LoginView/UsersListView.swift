//
//  UsersListView.swift
//  MotoApp
//
//  Created by Роман on 29.11.2023.
//

import SwiftUI
import RealmSwift

struct UsersListView: View {
    @ObservedResults(User.self) var users
    
    var body: some View {
        VStack{
            if users.isEmpty {
                Text("Нету созданных гаражей")
            }
            
            List {
                ForEach(users) { user in
                    Text(user.login)
                }.onDelete(perform: $users.remove)
            }
        }
    }
}

#Preview {
    UsersListView()
}
