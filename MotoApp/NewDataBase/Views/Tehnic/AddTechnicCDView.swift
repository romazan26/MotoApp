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
    var body: some View {
        VStack {
            Text("Новая техника")
                .font(.title)
            CustomTextFieldUIView(text: $vm.titleTehnic, placeHolder: "Название")
                .focused($nameIsFocused)
            
            CustomTextFieldUIView(text: $vm.typeTehnic, placeHolder: "Тип")
                .focused($nameIsFocused)
            
            CustomTextFieldUIView(text: $vm.noteTehnic, placeHolder: "Примечание")
                .focused($nameIsFocused)
            
            Spacer()
            
            //MARK: - Add Button
            ButtonView(action: {
                vm.addTehnic()
                dismiss()
            }, label: "Добавить технику")
            
        }
        .onTapGesture {
            nameIsFocused = false
        }
        .padding()
    }
}

#Preview {
    AddTechnicCDView(vm: CoreDataViewModel())
}
