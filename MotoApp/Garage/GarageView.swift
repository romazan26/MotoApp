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
                Text("Список техники пуст. Нажмите + чтобы добавить технику" )
            }
            List{
                ForEach(viewmodel.technics) { technic in
                    NavigationLink {
                        WorksUIView(viewModel: WorksViewModel(technic: technic))
                    } label: {
                        technicUIViewCell(technic: technic).bold()
                    }
                }.onDelete(perform: $viewmodel.user.technics.remove)
                    .listRowBackground( BlurUIView(style: .light).opacity(0.8))
                
                //MARK: - Button Add
                ButtonView(action: {
                    viewmodel.isPresented.toggle()
                }, label: "Добавить")
                .sheet(isPresented: $viewmodel.isPresented, content: {
                    AddTechnicUIView(viewmodel: viewmodel)
                })
            }
            .background(ZStack{
                Image(.moto)
                    .resizable()
                    .frame(width: 380, height: 220)
                    .offset(y: -30)

                BlurUIView(style: .light)
                    .ignoresSafeArea()
                    .opacity(0.8)
            })
            .scrollContentBackground(.hidden)
            
//            //MARK: - Button Add
//            ButtonView(action: {
//                viewmodel.isPresented.toggle()
//            }, label: "Добавить")
//            .sheet(isPresented: $viewmodel.isPresented, content: {
//                AddTechnicUIView(viewmodel: viewmodel)
//            }).offset(x: screenSize.width - 300, y: screenSize.height - 550)
            
        }
        
    }
}

#Preview {
    GarageView(viewmodel: GarageViewModel(user: DataManager.shared.createTempData()))
}
