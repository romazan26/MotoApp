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
        ZStack {
            Image("serii-kirpich-fon")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.5)
            VStack {
                    if user.technics.isEmpty {
                        Text("Список техники пуст. Нажмите + чтобы добавить технику" )
                    }
                    Text("Garage: \(user.garageName)")
                    List{
                        ForEach(user.technics) { technic in
                            NavigationLink {
                                WorksUIView(technis: technic)
                            } label: {
                                technicUIViewCell(technic: technic)
                            }

                            
                        }.onDelete(perform: $user.technics.remove)
                        
                        ButtonView(action: {
                            isPresented.toggle()
                        }, label: "Добавить")
                        .sheet(isPresented: $isPresented, content: {
                            AddTechnicUIView(user: user)
                        })
                    }
                    
            }
        }
        
    }
}

#Preview {
    GarageView(user: DataManager.shared.createTempData())
}
