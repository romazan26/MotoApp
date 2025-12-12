//
//  EditeCheckListView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 18.11.2025.
//

import SwiftUI

struct EditeCheckListView: View {
    @StateObject var vm: EditeCheckListViewModel
    @Environment(\.dismiss) var dismiss
    @FocusState var isFocusedSta: Bool
    var body: some View {
        ZStack {
            Color.grayApp.ignoresSafeArea()
            VStack {
                CustomTopBarView(barText: "editButtonLabel")
                VStack{
                    CustomTexrFieldStrokeview(title: "titleLabel", text: $vm.titleCheckList)
                        .focused($isFocusedSta)
                        .padding(.top)
                    Divider()
                    ScrollView {
                        ForEach(vm.itemsCheckList, id: \.self) { item in
                            HStack{
                                Text(item.title ?? "")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Button {
                                    vm.deleteOldItem(item: item)
                                } label: {
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundStyle(.red)
                                }

                            }
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
                            }
                        }
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
                        vm.saveEditingCheckList {
                            dismiss()
                        }
                    } label: {
                        GradientButtonView(label: "saveButtonLabel", color: .teracot)
                           // .opacity(vm.canAddCheckList ? 1 : 0.5)
                    }
                    //.disabled(!vm.canAddCheckList)
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
    EditeCheckListView(vm: EditeCheckListViewModel(editList: Checklist(context: CoreDataManager.instance.context)))
}
