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
    @State var title = LocalizedStringKey("titleLabel")
    var body: some View {
        VStack {
            Text(vm.isEditMode ? "editButtonLabel" : "addTechicViewLabel")
                .font(.title)
            
            //MARK: - Choose photo button
            Button {
                vm.isPresentPhotoPicker = true
            } label: {
                if let photo = vm.simplePhoto {
                    Image(uiImage: photo)
                        .resizable()
                        .frame(width: 300, height: 300)
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(20)
                }else{
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .cornerRadius(20)
                        .foregroundStyle(.gray)
                }
            }

            ShadowTextFieldView(placeholder: "titleLabel", text: $vm.titleTehnic)
                .focused($nameIsFocused)
            
            ShadowTextFieldView(placeholder: "typeLabel", text: $vm.typeTehnic)
                .focused($nameIsFocused)
            
            ShadowTextFieldView(placeholder: "noteLabel", text: $vm.noteTehnic)
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
                GradientButtonView(label: vm.isEditMode ? "saveButtonLabel" : "addTechinbuttonLabel", color: .black)
            }
            
        }
        .sheet(isPresented: $vm.isPresentPhotoPicker, content: {
            PhotoPicker(configuration: vm.config, pickerResult: $vm.simplePhoto, isPresented: $vm.isPresentPhotoPicker)
        })
        .onTapGesture {
            nameIsFocused = false
        }
        .padding()
    }
}

#Preview {
    AddTechnicCDView(vm: CoreDataViewModel())
}
