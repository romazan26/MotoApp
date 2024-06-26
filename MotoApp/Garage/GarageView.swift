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
    @StateObject var viewModelLogin: LoginViewModel
    @Environment(\.dismiss) var dismiss
        
    private let screenSize = UIScreen.main.bounds
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewmodel.technics.isEmpty {
                        Text("Список техники пуст. Добавте технику в гараж" )
                            .font(.title3)
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
                                        .cornerRadius(10)
                                }
                            }
                            .onDelete(perform: $viewmodel.user.technics.remove)
                            .listRowBackground( BlurUIView(style: .light)
                                .opacity(0.7)
                                .shadow(radius: 10))
                        }
                        .listRowSpacing(10)
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
                }
                    
            }.background(BackgroundCustom())
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                        viewModelLogin.logout()
                    }, label: {
                        Text("Выход")
                    })
                }
                
               
            }
        }
    }
}

#Preview {
    GarageView(viewmodel: GarageViewModel(user: DataManager.shared.createTempData()), viewModelLogin: LoginViewModel())
}
