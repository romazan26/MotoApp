//
//  AddNewChecklistView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 21.05.2025.
//

import SwiftUI

struct AddNewChecklistView: View {
    @StateObject var vm = AddCheckListViewModel()
    @Environment(\.dismiss) var dismiss
    @FocusState var isFocusedSta: Bool
    var body: some View {
        ZStack {
            Color.grayApp.ignoresSafeArea()
            VStack {
                CustomTopBarView(barText: "labelNewChecklist")
                VStack{
                    CustomTexrFieldStrokeview(title: "titleLabel", text: $vm.titleCheckList)
                        .focused($isFocusedSta)
                        .padding(.top)
                    Divider()
                    ScrollView {
                        
                        ForEach(Array(vm.items.enumerated()), id: \.element) { index, item in
                            CellNewItemCheckListView(title: item) {
                                vm.deleteItem(at: index)
                            }
                        }
                        
                        CustomTexrFieldStrokeview(title: "labelNewItemCheckList", text: $vm.titleItem)
                            .padding(.top)
                        
                        //MARK: - Add item for list
                        Button {
                            vm.addNewItem()
                        } label: {
                            PlusButtonOneItemView()
                                .opacity(vm.canAddItem ? 1 : 0.5)
                        }
                        .disabled(!vm.canAddItem)
                    }
                    
                    Spacer()
                    Button {
                        vm.addNewCheckList {
                            dismiss()
                        }
                    } label: {
                        GradientButtonView(label: "saveButtonLabel", color: .teracot)
                            .opacity(vm.canAddCheckList ? 1 : 0.5)
                    }
                    .disabled(!vm.canAddCheckList)
                }.padding()
            }
            if vm.isLoading {
                ProgressView()
            }
        }
        .navigationBarBackButtonHidden()
        //MARK: Swipe to back
        .gesture(
            DragGesture()
                .onEnded { gesture in
                    if gesture.translation.width > 50 { // Свайп вправо
                        dismiss()
                    }
                }
        )
    }
}

#Preview {
    AddNewChecklistView()
}
