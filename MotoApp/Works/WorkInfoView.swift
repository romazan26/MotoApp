//
//  WorkInfoView.swift
//  MotoApp
//
//  Created by Роман on 03.07.2024.
//

import SwiftUI

struct WorkInfoView: View {
    @ObservedObject var vm: WorksViewModel
    @Environment(\.dismiss) var dismiss
    let work: Work
    var body: some View {
        ZStack {
            BackgroundCustom().blur(radius: 3.0)
            VStack{
                
                //MARK: - Text field group
            VStack(alignment: .leading) {
                Text("Название работы")
                TextField(work.nameWork, text: $vm.simpleNamework, axis: .vertical)
                    .font(.system(size: 30, weight: .heavy, design: .serif))
                Text("одометр")
                CustomTextFieldUIView(text: $vm.simpleOdometr, placeHolder: String(work.odometr))
                
                Text("Цена")
                CustomTextFieldUIView(text: $vm.simplePrice, placeHolder: String(work.price))
                
                Text("Дата: \(String(work.date.formatted()))")
            }
                Spacer()
                
                //MARK: - Save edite button
                ButtonView(action: {
                    vm.upDataWork(id: work.id)
                    dismiss()
                }, label: "Изменить")
            }.padding()
        }
        .onAppear(perform: {
            vm.fillData(id: work.id)
            print(vm.simpleNamework)
        })
    }
}

#Preview {
    WorkInfoView(vm: WorksViewModel(technic: DataManager.shared.createTempDataTechic()), work: Work())
}
