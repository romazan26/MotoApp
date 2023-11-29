//
//  ProfileView.swift
//  MotoApp
//
//  Created by Роман on 27.09.2023.
//

import SwiftUI
import RealmSwift

struct ProfileView: View {
    @ObservedRealmObject var user: User
    @State var simpleUserName = ""
    @State var simpleUserSerName = ""

    var body: some View {
        
        VStack {
            Text("User: \(user.name)")
            Image(systemName: "person")
                .resizable()
                .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            TextField(user.name, text: $simpleUserName)
                .textFieldStyle(.roundedBorder)
            TextField(user.serName, text: $simpleUserSerName)
                .textFieldStyle(.roundedBorder)
            Button("addname") {
                update()
            }
        }
        
    }
    func update() {
        do{
            let realm = try Realm()
            guard let objecttoupdate = realm.object(ofType: User.self, forPrimaryKey: user.id) else {
                return
            }
            try realm.write {
                objecttoupdate.name = simpleUserName
                objecttoupdate.serName = simpleUserSerName
            }
            
        }catch{print(error)}
    }
}

#Preview {
    ProfileView( user: User())
}
