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
            Text(vm.isEditorWork ? "Изменить работу" :  "Новая работа")
                .font(.title)
            ResizebleTextFieldView(text: $vm.simpleTitleWork, extraHeight: 40)
                .focused($nameIsFocused)
                
            ShadowTextFieldView(placeholder: "Одометр", text: $vm.simpleOdometer)
                .focused($nameIsFocused)
                .keyboardType(.numberPad)
            
            ShadowTextFieldView(placeholder: "Стоимость", text: $vm.simplePrice)
                .focused($nameIsFocused)
                .keyboardType(.numberPad)
            
            DatePicker("Дата:", selection: $vm.simpleDate)
                .padding()
                .background(Color.back)
                .clipShape(RoundedRectangle(cornerRadius: 10,style: .continuous))
                .shadow(color: .gray, radius: 8, x: 8, y: 8)
                .shadow(color: .back, radius: 8, x: -8, y: -8)
            
            Spacer()
            
            //MARK: - Add Button
            ButtonView(action: {
                if vm.isEditorWork {
                    vm.editWork()
                }else{
                    vm.addWork(technic: tehnic )
                }
                dismiss()
            }, label: "Сохранить")
            
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
