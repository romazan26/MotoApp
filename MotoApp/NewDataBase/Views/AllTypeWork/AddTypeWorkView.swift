//
//  AddTypeWorkView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 01.07.2025.
//

import SwiftUI

struct AddTypeWorkView: View {
    @StateObject var vm: TypeWorkViewModel
    var body: some View {
        ZStack {
            Color.black.opacity(0.2).ignoresSafeArea()
            VStack {
                
                TextField("newTypeLabel", text: $vm.newTypeName)
                    .textFieldStyle(.roundedBorder)
                Button {
                    vm.saveNewTypeWork()
                } label: {
                    GradientButtonView(label: "addButton")
                        .opacity(vm.newTypeName.isEmpty ? 0.2 : 1)
                }.disabled(vm.newTypeName.isEmpty)

            }
            .padding()
            .background(content: {
                Color.grayApp.cornerRadius(20)
            })
            .padding()
        }
        .onTapGesture {
            vm.isPresentAddTypeView.toggle()
        }
    }
}

#Preview {
    AddTypeWorkView(vm: TypeWorkViewModel())
}
