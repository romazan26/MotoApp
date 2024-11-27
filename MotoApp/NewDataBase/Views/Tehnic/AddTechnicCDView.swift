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
            Text("addTechicViewLabel")
                .font(.title)
            ShadowTextFieldView(placeholder: "titleLabel", text: $vm.titleTehnic)
                .focused($nameIsFocused)
            
            ShadowTextFieldView(placeholder: "typeLabel", text: $vm.typeTehnic)
                .focused($nameIsFocused)
            
            ShadowTextFieldView(placeholder: "noteLabel", text: $vm.noteTehnic)
                .focused($nameIsFocused)
                    
            Spacer()
            
            //MARK: - Add Button
            Button {
                vm.addTehnic()
                dismiss()
            } label: {
                GradientButtonView(label: "addTechinbuttonLabel", color: .back)
            }
            
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
