//
//  GarageView.swift
//  MotoApp
//
//  Created by Роман on 27.09.2023.
//

import SwiftUI
import RealmSwift

struct GarageView: View {
    
    @StateObject var viewmodel: GarageViewModel
        
    private let screenSize = UIScreen.main.bounds
    
    var body: some View {
        ZStack {
            if viewmodel.technics.isEmpty {
                Text("Список техники пуст. Добавте технику в гараж" ).font(.title3)
            }
            VStack {
                
                //MARK: - Technic List
                ScrollViewReader { proxy in
                    List{
                        ForEach(viewmodel.technics) { technic in
                            NavigationLink {
                                WorksUIView(viewModel: WorksViewModel(technic: technic))
                            } label: {
                                technicUIViewCell(technic: technic)
                                    .bold()
                                    .cornerRadius(10)
                                    .padding(.horizontal, -10)
                            }
                        }
                        .onDelete(perform: $viewmodel.user.technics.remove)
                        .listRowBackground( BlurUIView(style: .light)
                            .opacity(0.7)
                            .shadow(radius: 10))
                    }
                    .onChange(of: viewmodel.lastTechnicId, perform: { id in
                        proxy.scrollTo(id, anchor: .bottom)
                    })
                    .scrollContentBackground(.hidden)
                }
                
                //MARK: - Button Add
                ButtonView(action: {
                    viewmodel.isPresented.toggle()
                }, label: "Добавить")
                .sheet(isPresented: $viewmodel.isPresented, content: {
                    AddTechnicUIView(viewmodel: viewmodel)
                })
            }.background(BackgroundCustom())
        }
    }
}

#Preview {
    GarageView(viewmodel: GarageViewModel(user: DataManager.shared.createTempData()))
}
