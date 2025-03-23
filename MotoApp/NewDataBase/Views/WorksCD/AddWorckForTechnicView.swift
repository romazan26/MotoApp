//
//  AddWorckForTechnicView.swift
//  MotoApp
//
//  Created by Роман on 15.11.2024.
//

import SwiftUI

struct AddWorckForTechnicView: View {
    
    @ObservedObject var vm: WorkCDViewmodel
    @Environment(\.dismiss) private var dismiss
    @FocusState private var nameIsFocused: Bool
    @State private var animate = false
    
    var body: some View {
        ZStack {
            Color.grayApp.ignoresSafeArea()
            VStack {
                //MARK: - Top tool bar
                HStack{
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 20, height: 80)
                            .shadow(radius: 5)
                    }
                    .padding(.trailing, 10)
                    if !vm.isEditorWork{
                        if let imageData = vm.convertDataToImage(vm.technicCD.photo){
                            Image(uiImage: imageData)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }else{
                            Image(.newLogo)
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                    }else{
                        Image(.newLogo)
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    
                    Spacer()
                    
                    Text(vm.isEditorWork ? "editViewLabel" :  "addNewWorkViewLabel")
                        .foregroundStyle(.white)
                        .font(.system(size: 30, weight: .bold, design: .serif))
                        .minimumScaleFactor(0.5)
                    Spacer()
                    
                }
                .padding()
                .background {TopbarBackGroundView(animate: $animate)}
                .onAppear {
                    self.animate = true
                }
                
                .shadow(color: .black, radius: 15)
                
                
                    .font(.title)
                
                //MARK: - Text field group
                VStack{
                    
                    CustomTexrFieldStrokeview(title: "titleLabel", text: $vm.simpleTitleWork)
                        .focused($nameIsFocused)
                    
                    CustomTexrFieldStrokeview(title: "odometrLabel", text: $vm.simpleOdometer)
                        .focused($nameIsFocused)
                        .keyboardType(.numberPad)
                    
                    CustomTexrFieldStrokeview(title: "priceLabel", text: $vm.simplePrice)
                        .focused($nameIsFocused)
                        .keyboardType(.numberPad)
                    
                    CustomDatePicker(selectedDate: $vm.simpleDate)
                        
                    
                    Spacer()
                    
                    //MARK: - Add Button
                    
                    Button {
                        if vm.isEditorWork {
                            vm.editWork()
                        }else{
                            vm.addWork()
                        }
                        dismiss()
                    } label: {
                        GradientButtonView(label: "saveButtonLabel", color: vm.simpleTitleWork.isEmpty ? .black : .green)
                            .opacity(vm.simpleTitleWork.isEmpty ? 0.5 : 1)
                    }.disabled(vm.simpleTitleWork.isEmpty)
                }
                .onTapGesture {
                    nameIsFocused = false
                }
                .padding(.top, 20)
                .padding()
            }
            .navigationBarBackButtonHidden(true)
            .onTapGesture {
                nameIsFocused = false
            }
        }
        .onDisappear {
            vm.clearWork()
        }
        .onTapGesture {
            nameIsFocused = false
        }
        
    }
    
    
}
#Preview {
    AddWorckForTechnicView(vm: WorkCDViewmodel(technicCD: TechnicCD(context: CoreDataManager.instance.context)))
}


