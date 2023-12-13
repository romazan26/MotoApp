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
    private let screenSize = UIScreen.main.bounds
    
    var body: some View {
        ZStack {
                    if user.technics.isEmpty {
                        Text("Список техники пуст. Нажмите + чтобы добавить технику" )
                    }
                    Text("Garage: \(user.garageName)")
                    List{
                        ForEach(user.technics) { technic in
                            NavigationLink {
                                WorksUIView(technis: technic)
                            } label: {
                                technicUIViewCell(technic: technic).bold()
                            }
                        }.onDelete(perform: $user.technics.remove)
                            .listRowBackground( LinearGradient(
                            colors: [.orange, .blue.opacity(0.9)],
                            startPoint: .bottomLeading,
                            endPoint: .topTrailing).opacity(0.8))
                        
                    }
                    .background(LinearGradient(
                        colors: [.orange, .blue.opacity(0.8)],
                        startPoint: .bottomLeading,
                        endPoint: .topTrailing).opacity(0.6))
                    .scrollContentBackground(.hidden)
                    
                ButtonView(action: {
                    isPresented.toggle()
                }, label: "Добавить")
                .sheet(isPresented: $isPresented, content: {
                    AddTechnicUIView(user: user)
                }).offset(x: screenSize.width - 300, y: screenSize.height - 550)
            
        }
        
    }
}

#Preview {
    GarageView(user: DataManager.shared.createTempData())
}
