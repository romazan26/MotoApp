//
//  SimpleCheckListView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 26.05.2025.
//

import SwiftUI

struct SimpleCheckListView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: SimpleCheckListViewModel
    var body: some View {
        ZStack {
            Color.grayApp.ignoresSafeArea()
            VStack {
                CustomTopBarView(barText: "\(viewModel.checkList.title ?? "")", titleUp: viewModel.checkList.title ?? "")
                
               
                    //MARK: - Items list
                    ScrollView {
                        VStack{
                        ForEach(viewModel.items) { item in
                            Button {
                                viewModel.completeItem(item: item)
                            } label: {
                                CellItemCheckListView(nameItem: item.title ?? "", complited: item.completed)
                            }
                        }
                        }.padding()
                    }
                    //MARK: - Delete and reset Button
                    HStack{
                        Button {
                            viewModel.isPresentDeleteAlert.toggle()
                        } label: {
                            GradientButtonView(label: "deleteLabel", color: .red)
                        }
                        
                        Spacer()
                        
                        Button {
                            viewModel.resetCheckList()
                        } label: {
                            GradientButtonView(label: "resetLabel", color: .orange)
                        }
                    }
                    .padding()
                    .padding(.bottom, 25)                
            }
            .navigationBarBackButtonHidden()
        }
        //MARK: - Delete alert
        .alert(isPresented: $viewModel.isPresentDeleteAlert) {
            Alert(title: Text("deleteCheckListMessage"), primaryButton: .cancel(), secondaryButton: .default(Text("deleteLabel"), action: {
                dismiss()
                viewModel.deleteCheckList()
            }))
        }
        //MARK: - Back slide
        .gesture(
            DragGesture()
                .onEnded({ gesture in
                    if gesture.translation.width > 50 {
                        dismiss()
                    }
                })
            
        )
    }
}

#Preview {
    SimpleCheckListView(viewModel: SimpleCheckListViewModel(checkList: Checklist(context: CoreDataManager.instance.context)))
}
