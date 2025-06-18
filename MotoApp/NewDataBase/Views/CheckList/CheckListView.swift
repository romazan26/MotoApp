//
//  CheckList.swift
//  MotoApp
//
//  Created by Роман Главацкий on 07.05.2025.
//

import SwiftUI

struct CheckListView: View {
    
    @StateObject private var vm = CheckListViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.grayApp.ignoresSafeArea()
                
                VStack {
                    CustomTopBarView(barText: "labelCheckLists")
                    GeometryReader { geo in
                        ZStack(alignment: .bottomTrailing) {
                            //MARK: - List of checklist
                            ScrollView{
                                VStack{
                                    if vm.checkList.isEmpty {
                                        Text("No checklist")
                                            .foregroundColor(.black)
                                            .multilineTextAlignment(.center)
                                            .frame(height: geo.size.height)
                                    }else{
                                        ForEach(vm.checkList) { checkList in
                                            NavigationLink {
                                                SimpleCheckListView(viewModel: SimpleCheckListViewModel(checkList: checkList))
                                            } label: {
                                                CellCheckListView(nameCheckList: checkList.title ?? "Untitled",
                                                                  countCheckListItem: vm.getCountItem(list: checkList),
                                                                  completed: vm.checkAllItem(list: checkList))
                                            }
                                        }
                                    }
                                }
                                .padding()
                                .frame(width: geo.size.width)
                            }
                            
                            //MARK: - Plus button
                            NavigationLink {
                                AddNewChecklistView()
                            } label: {
                                PlusCircleButtonView()
                            }
                            .padding()
                        }
                    }
                }
            }
            .onAppear {
                vm.updateCheckList()
            }
        }
    }
}

#Preview {
    CheckListView()
}
