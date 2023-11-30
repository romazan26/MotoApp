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
    @State private var garageName = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        
        ZStack {
            Image("serii-kirpich-fon")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.5)
            VStack {
                Text(user.garageName)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .shadow(color: .blue, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .bold()
                Text("\(user.name) \(user.serName)")
                    .font(.largeTitle)
                    .bold()
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                TextField(user.name, text: $simpleUserName)
                    .customStyle()
                    .focused($isFocused)
                TextField(user.serName, text: $simpleUserSerName)
                    .customStyle()
                    .focused($isFocused)
                TextField(user.garageName, text: $garageName)
                    .customStyle()
                    .focused($isFocused)
                ButtonView(action: {
                    update()
                }, label: "Изменить данные")
            }.padding()
        }.onTapGesture {
            isFocused = false
        }
        
    }
//MARK: - update fnction
    func update() {
        do{
            let realm = try Realm()
            guard let objecttoupdate = realm.object(ofType: User.self, forPrimaryKey: user.id) else {
                return
            }
            try realm.write {
                if !simpleUserName.isEmpty
                {objecttoupdate.name = simpleUserName}
                if !simpleUserSerName.isEmpty
                {objecttoupdate.serName = simpleUserSerName}
                if !garageName.isEmpty
                {objecttoupdate.garageName = garageName}
            }
        }catch{print(error)}
    }
}

#Preview {
    ProfileView( user: DataManager.shared.createTempData())
}
