//
//  AddWorckForTechnicView.swift
//  MotoApp
//
//  Created by Роман on 15.11.2024.
//

import SwiftUI

struct AddWorckForTechnicView: View {
    
    let tehnic: TechnicCD
    @ObservedObject var vm: CoreDataViewModel
    @Environment(\.dismiss) private var dismiss
    @FocusState private var nameIsFocused: Bool
    
    var body: some View {
        VStack {
            Text(vm.isEditorWork ? "Change the job" :  "addNewWorkViewLabel")
                .font(.title)
            ResizebleTextFieldView(text: $vm.simpleTitleWork, extraHeight: 40)
                .focused($nameIsFocused)
                
            ShadowTextFieldView(placeholder: "odometrLabel", text: $vm.simpleOdometer)
                .focused($nameIsFocused)
                .keyboardType(.numberPad)
            
            ShadowTextFieldView(placeholder: "priceLabel", text: $vm.simplePrice)
                .focused($nameIsFocused)
                .keyboardType(.numberPad)
            
            DatePicker("dateLabel", selection: $vm.simpleDate)
                .padding()
                .background(Color.back)
                .clipShape(RoundedRectangle(cornerRadius: 10,style: .continuous))
                .shadow(color: .gray, radius: 8, x: 8, y: 8)
                .shadow(color: .back, radius: 8, x: -8, y: -8)
            
            Spacer()
            
            //MARK: - Add Button
            
            Button {
                if vm.isEditorWork {
                    vm.editWork()
                }else{
                    vm.addWork(technic: tehnic )
                }
                dismiss()
            } label: {
                GradientButtonView(label: "saveButtonLabel", color: .green)
            }
        }
        
        .onTapGesture {
            nameIsFocused = false
        }
        .padding()
    }
    
}

#Preview {
    AddWorckForTechnicView( tehnic: TechnicCD(), vm: CoreDataViewModel())
}
