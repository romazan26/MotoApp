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
   
    //MARK: - Body
    var body: some View {
        ZStack {
            if viewModel.technic.works.isEmpty {
                    Text("Нет выполненных работ")
                }
            VStack {
            //MARK: - works List
                ScrollViewReader { proxy in
                    List {
                            ForEach(viewModel.technic.works) { work in
                                    Button(action: {
                                        viewModel.workToEdite = work
                                        viewModel.isPresentedAlertEdite.toggle()
                                    }) {
                                        WorkCellView(work: work).padding(.horizontal, -10)
                                    }
                                .listRowBackground( BlurUIView(style: .light).opacity(0.7))
                            }.onDelete(perform: $viewModel.technic.works.remove)
                        }
                    .onChange(of: viewModel.lastWorkId, perform: { id in
                        proxy.scrollTo(id, anchor: .bottom)
                    })
                        .background(BackgroundCustom())
                    .scrollContentBackground(.hidden)
                }
                
                //MARK: - Add Button
                ButtonView(action: {
                    viewModel.isPresentedAlert.toggle()
                }, label: "Добавить работу")
                .padding(.bottom, 55)
            }
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
