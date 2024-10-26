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
            VStack(alignment: .center, spacing: 20) {
                //MARK: - Title
                Text("Введите данные о работе")
                    .font(.system(size: 32, weight: .heavy))
                    .multilineTextAlignment(.center)
                
                //MARK: - work name
                TextField("Название работы", text: $vm.simpleNamework, axis: .vertical)
                    .font(.system(size: 30, weight: .heavy, design: .serif))
                    .focused($keyboardIsFocused)
                    .padding()
                    .background(Color.back)
                    .clipShape(RoundedRectangle(cornerRadius: 10,style: .continuous))
                    .shadow(color: .gray, radius: 8, x: 8, y: 8)
                    .shadow(color: .back, radius: 8, x: -8, y: -8)
                
                //MARK: - mileage
                CustomTextFieldUIView(text: $vm.simpleOdometr, placeHolder: "одометр")
                    .focused($keyboardIsFocused)
                    .keyboardType(.numberPad)
            
                //MARK: - Price
                CustomTextFieldUIView(text: $vm.simplePrice, placeHolder: "Цена")
                    .focused($keyboardIsFocused)
                    .keyboardType(.numberPad)
                
                //MARK: - Date
                DatePicker("Дата:", selection: $vm.simpleDate, displayedComponents: .date)
                    .padding(.horizontal, 10)
                    .font(.title)
                
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
