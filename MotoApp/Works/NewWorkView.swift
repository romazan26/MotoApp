//
//  NewWorkView.swift
//  MotoApp
//
//  Created by Роман on 03.07.2024.
//

import SwiftUI

struct NewWorkView: View {
    @ObservedObject var vm: WorksViewModel
    @Environment(\.dismiss) var dismiss
    @FocusState private var keyboardIsFocused: Bool

    var body: some View {
        ZStack {
            BackgroundCustom().blur(radius: 3.0)
            VStack{
                
                //MARK: - Text field group
            VStack(alignment: .leading, spacing: 20) {
                //MARK: - Title
                Text("Введите название")
                
                //MARK: - work name
                TextField("Название работы", text: $vm.simpleNamework, axis: .vertical)
                    .font(.system(size: 30, weight: .heavy, design: .serif))
                    .focused($keyboardIsFocused)
                
                //MARK: - mileage
                CustomTextFieldUIView(text: $vm.simpleOdometr, placeHolder: "одометр")
                    .focused($keyboardIsFocused)
                    .keyboardType(.numberPad)
            
                //MARK: - Price
                CustomTextFieldUIView(text: $vm.simplePrice, placeHolder: "Цена")
                    .focused($keyboardIsFocused)
                    .keyboardType(.numberPad)
                
                Text("Дата: \(String(Date.now.formatted()))")
            }
                Spacer()
                
                //MARK: - Save edite button
                ButtonView(action: {
                    vm.addWork()
                    dismiss()
                }, label: "Добавить")
            }.padding()
                .navigationTitle("Новая работа")
        }
        .onAppear(perform: {
            vm.clear()
        })
        .onTapGesture {
            keyboardIsFocused = false
    }
        .minimumScaleFactor(0.5)
    }
}

#Preview {
    NewWorkView(vm: WorksViewModel(technic: DataManager.shared.createTempDataTechic()))
}
