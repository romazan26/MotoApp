//
//  AddTechnicView.swift
//  MotoApp
//
//  Created by Роман on 27.10.2024.
//

import SwiftUI

struct AddTechnicCDView: View {
    @StateObject var vm: CoreDataViewModel
    @Environment(\.dismiss) private var dismiss
    @FocusState private var nameIsFocused: Bool
    @State private var animate = false
    
    var body: some View {
        ZStack {
            Color.grayApp.ignoresSafeArea()
            VStack(spacing: 15) {
                //MARK: - Top tool bar
                HStack{
                    Button {
                        dismiss()
                        vm.clearTehnic()
                    } label: {
                        Image(systemName: "chevron.left.circle")
                            .resizable()
                            .foregroundStyle(.white)
                            .frame(width: 35, height: 35)
                    }

                    Spacer()
                    Text(vm.isEditMode ? "editButtonLabel" : "addTechicViewLabel")
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
                
                VStack(spacing: 20){
                    //MARK: - Choose photo button
                    Button {
                        vm.isPresentPhotoPicker = true
                    } label: {
                        if let photo = vm.simplePhoto {
                            Image(uiImage: photo)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 300, height: 300)
                                .cornerRadius(20)
                        }else{
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 300, height: 300)
                                .cornerRadius(20)
                                .foregroundStyle(.gray)
                        }
                    }
                    CustomTexrFieldStrokeview(title: "titleLabel", text: $vm.titleTehnic)
                        .focused($nameIsFocused)
                    
                    CustomTexrFieldStrokeview(title: "typeLabel", text: $vm.typeTehnic)
                        .focused($nameIsFocused)
                    CustomTexrFieldStrokeview(title: "noteLabel", text: $vm.noteTehnic)
                        .focused($nameIsFocused)
                    
                    
                    Spacer()
                    
                    //MARK: - Add Button
                    Button {
                        if vm.isEditMode{
                            vm.saveEdit()
                        }else{
                            vm.addTehnic()
                        }
                        
                        dismiss()
                    } label: {
                        GradientButtonView(label: vm.isEditMode ? "saveButtonLabel" : "addTechinbuttonLabel",color: .black)
                            .shadow(color: .black, radius: 10)
                            .opacity(vm.titleTehnic.isEmpty ? 0.2 : 1)
                    }.disabled(vm.titleTehnic.isEmpty)
                    
                }
                .sheet(isPresented: $vm.isPresentPhotoPicker, content: {
                    PhotoPicker(configuration: vm.config, pickerResult: $vm.simplePhoto, isPresented: $vm.isPresentPhotoPicker)
                })
                .onTapGesture {
                    nameIsFocused = false
                }
                .padding()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    AddTechnicCDView(vm: CoreDataViewModel())
}
