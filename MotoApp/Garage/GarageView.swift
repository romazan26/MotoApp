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
    @StateObject var vm = CoreDataViewModel()
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
                            .listRowBackground( Color.clear)
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
                .onAppear {
                    viewmodel.loadData()
                }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                        viewModelLogin.logout()
                    }, label: {
                        Text("Выход")
                    })
                }
                
                ToolbarItem {
                    Text(viewmodel.coreDataActive ? "true" : "false")
                        .foregroundStyle(viewmodel.coreDataActive ? .green : .red)
                }
                
                //                ToolbarItem {
                //                    Button {
                //                        viewmodel.deleteAll()
                //                    } label: {
                //                        Text("delete all")
                //                    }
                //
                //                }
                //
                //                ToolbarItem {
                //                    NavigationLink("List") {
                //                        ListCoreData(vm: vm)
                //                    }
                //                }
                
                ToolbarItem {
                    Button {
                        if !viewmodel.technicsCD.isEmpty {
                            print("Get data base ")
                        }else{
                            viewmodel.loadData()
                        }
                        
                    } label: {
                        Text("Загрузить базу")
                    }
                    
                }
                
            }
                if viewmodel.coreDataActive {
                    ZStack{
                        Color.black.opacity(0.5)
                        Text("База загружена, перезапустите приложение")
                            .foregroundStyle(.white)
                            .font(.title)
                    }
                }
            }
            .background(BackgroundCustom())
        }
    }
}

#Preview {
    GarageView(viewmodel: GarageViewModel(user: DataManager.shared.createTempData()), viewModelLogin: LoginViewModel())
}
