//
//  WorksUIView.swift
//  MotoApp
//
//  Created by Роман on 01.12.2023.
//

import SwiftUI

struct WorksUIView: View {
    //MARK: - Propety
    @ObservedObject var viewModel: WorksViewModel

    private let screenSize = UIScreen.main.bounds
    
    //MARK: - Body
    var body: some View {
        ZStack {
            if viewModel.technic.works.isEmpty {
                    Text("Нет выполненных работ")
                }
                //MARK: - Works name
                List {
                    ForEach(viewModel.technic.works) { work in
                        Group {
                            HStack {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("название: ")
                                        Text(work.nameWork).bold()
                                    }
                                    HStack {
                                        Text("Одометр: ")
                                        Text(String(work.odometr)).bold()
                                    }
                                    HStack {
                                        Text("Цена:        ")
                                        Text(String(work.price)).bold()
                                    }
                                    HStack {
                                        Text("Дата:        ")
                                        Text(String(work.date.formatted(date: .numeric, time: .shortened)))
                                    }
                                }
                                Spacer()
                               
                                Button(action: {
                                    viewModel.workToEdite = work
                                    viewModel.isPresentedAlertEdite.toggle()
                                }) {
                                    Image(systemName: "pencil.line")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                }
                            }
                        }
                        .listRowBackground( LinearGradient(
                            colors: [.orange, .blue.opacity(0.7)],
                            startPoint: .bottomLeading,
                            endPoint: .topTrailing).opacity(0.4))
                    }.onDelete(perform: $viewModel.technic.works.remove)
                }
                .background(LinearGradient(
                    colors: [.orange, .blue.opacity(0.8)],
                    startPoint: .bottomLeading,
                    endPoint: .topTrailing).opacity(0.6))
                .scrollContentBackground(.hidden)
                
                //MARK: - Add Button
                ButtonView(action: {
                    viewModel.isPresentedAlert.toggle()
                }, label: "Добавить работу")
                .offset(x: screenSize.width - 300, y: screenSize.height - 550)
            
            
            //MARK: - Show Alert add
            AddAertUIVuew(
                isShow: $viewModel.isPresentedAlert,
                text: $viewModel.nameWork,
                text2: $viewModel.odonetr,
                text3: $viewModel.price,
                place: "Название работы",
                place2: "Одометр",
                place3: "Цена",
                title: "Новая работа") { text in
                    viewModel.nameWork = text
                    viewModel.addWork()
            }
            
            //MARK: - Show Alert edite
            AddAertUIVuew(
                isShow: $viewModel.isPresentedAlertEdite,
                text: $viewModel.nameWork,
                text2: $viewModel.odonetr,
                text3: $viewModel.price,
                place: "Название работы",
                place2: "Одометр",
                place3: "Цена",
                title: "Редактировать") { text in
                    viewModel.nameWork = text
                    viewModel.upDateWork()
            }
        }
    }
   
    
   
    
}
//MARK: - Preview
#Preview {
    WorksUIView(viewModel: WorksViewModel(technic: DataManager.shared.createTempDataTechic()))
}
