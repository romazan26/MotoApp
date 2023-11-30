//
//  GarageView.swift
//  MotoApp
//
//  Created by Роман on 27.09.2023.
//

import SwiftUI
import RealmSwift

struct GarageView: View {
    @ObservedRealmObject var user: User
    @State private var nameTehnic = ""
    var body: some View {
        
        VStack {
            TextField("Name tehnic", text: $nameTehnic)
                .textFieldStyle(.roundedBorder)
            Button(action: {addTehnic()}, label: {
                Text("Add tehnic")
            })
        }
        .navigationTitle(Text("Garage: \(user.garageName)"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    print(user)
                },
                       label: {
                    Text("Add tehnic")
                })
            }
        }
    }
    
        
    
    
    private func addTehnic() {
        let tehnic = Technic()
        tehnic.title = nameTehnic
        $user.technics.append(tehnic)
        
    }
}

#Preview {
    GarageView(user: User())
}
