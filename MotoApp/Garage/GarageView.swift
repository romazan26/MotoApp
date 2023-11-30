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
    @State private var isPresented = false
    var body: some View {
            VStack {
                if user.technics.isEmpty {
                    Text("Список техники пуст. Нажмите + чтобы добавить технику" )
                }
                Text("Garage: \(user.garageName)")
                List{
                    ForEach(user.technics) { technic in
                        technicUIViewCell(technic: technic)
                    }.onDelete(perform: $user.technics.remove)
                    
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {isPresented.toggle()}
                    label: {Image(systemName: "plus")}
                }
            }.sheet(isPresented: $isPresented, content: {
                AddTechnicUIView(user: user)
        })
        
    }
}

#Preview {
    GarageView(user: DataManager.shared.createTempData())
}
