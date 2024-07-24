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
                HStack {
                    Image(.works)
                        .resizable()
                        .frame(width: 130, height: 100)
                    VStack(alignment: .leading) {
                        Text("\(viewModel.technic.title) \(viewModel.technic.note)")
                        Text("Одометр: \(viewModel.findOdometr())")
                        Text("Колличество работ: \(viewModel.technic.works.count)")
                        Text("Потрачено: \(viewModel.finalPrice())")
                    }
                Spacer()
                }
                .padding(10)
                .minimumScaleFactor(0.5)
                    .lineLimit(1)
                
                //MARK: - works List
                ScrollViewReader { proxy in
                    List {
                        ForEach(viewModel.sortWork) { work in
                            NavigationLink(destination: {
                                WorkInfoView(vm: viewModel, work: work)
                            }, label: {
                                WorkCellView(work: work)
                            })
                            .listRowBackground( Color.clear)
                            
                        }.onDelete(perform: $viewModel.technic.works.remove)
                    }
                    .listRowSpacing(10)
                    .onChange(of: viewModel.lastWorkId, perform: { id in
                        proxy.scrollTo(id, anchor: .bottom)
                    })
                    .scrollContentBackground(.hidden)
                }
                
                //MARK: - Add Button
                ButtonView(action: {
                    viewModel.isPresentedNewWorkView.toggle()
                }, label: "Добавить")
            }
            .sheet(isPresented: $viewModel.isPresentedNewWorkView, content: {
                NewWorkView(vm: viewModel)
            })
            .onAppear(perform: {
                viewModel.clear()
            })
            
           
        }
        //MARK: - ToolBar
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Menu("Сортировать") {
                    Picker("", selection: $viewModel.selectedSortOption) {
                        ForEach(SortOptionWork.allCases, id: \.rawValue) { option in
                            Label(option.rawValue, systemImage: "\(option)")
                                .tag(option)
                        }
                    }
                    .labelsHidden()
                }
            }
        })
        .background(BackgroundCustom())
        .navigationTitle(viewModel.technic.type)
        .animation(.easeIn, value: viewModel.sortWork)
    }
}

//MARK: - Preview
#Preview {
    WorksUIView(viewModel: WorksViewModel(technic: DataManager.shared.createTempDataTechic()))
}
