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

    var body: some View {
        ZStack {
            BackgroundCustom().blur(radius: 3.0)
            VStack{
                
                //MARK: - Text field group
            VStack(alignment: .leading, spacing: 20) {
                Text("Введите название")
                TextField("Название работы", text: $vm.simpleNamework, axis: .vertical)
                    .font(.system(size: 30, weight: .heavy, design: .serif))
                
                CustomTextFieldUIView(text: $vm.simpleOdometr, placeHolder: "одометр")
                
                
                CustomTextFieldUIView(text: $vm.simplePrice, placeHolder: "Цена")
                
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
        .minimumScaleFactor(0.5)
    }
}

#Preview {
    NewWorkView(vm: WorksViewModel(technic: DataManager.shared.createTempDataTechic()))
}
