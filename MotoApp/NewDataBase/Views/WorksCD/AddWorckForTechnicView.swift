//
//  AddWorckForTechnicView.swift
//  MotoApp
//
//  Created by Роман on 15.11.2024.
//

import SwiftUI

struct AddWorckForTechnicView: View {
    let tehnic: TechnicCD
    @StateObject var vm: CoreDataViewModel
    @Environment(\.dismiss) private var dismiss
    @FocusState private var nameIsFocused: Bool
    var body: some View {
        VStack {
            Text("Новая работа")
                .font(.title)
            CustomTextFieldUIView(text: $vm.simpleTitleWork, placeHolder: "Название работы")
                .focused($nameIsFocused)
            
            CustomTextFieldUIView(text: $vm.simpleOdometer, placeHolder: "Одометр")
                .focused($nameIsFocused)
                .keyboardType(.numberPad)
            
            CustomTextFieldUIView(text: $vm.simplePrice, placeHolder: "Стоимость")
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
                vm.addWork(technic: tehnic )
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
