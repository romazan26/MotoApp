//
//  AddTechnicUIView.swift
//  MotoApp
//
//  Created by Роман on 30.11.2023.
//

import SwiftUI
import RealmSwift

struct AddTechnicUIView: View {
    
    //MARK: - Propertys
    @StateObject var viewmodel: GarageViewModel
    
    @Environment(\.dismiss) private var dismiss
    @FocusState private var nameIsFocused: Bool
    
    //MARK: - Body
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.black, .blue.opacity(0.7)],
                startPoint: .bottomLeading,
                endPoint: .topTrailing)
            .opacity(0.7)
            .ignoresSafeArea()
            
            VStack {
                Text("Введите данные о технике")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .shadow(color: .blue, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                //MARK: - TextField group
                CustomTextFieldUIView(text: $viewmodel.typeTehnic, placeHolder: "Тип")
                    .focused($nameIsFocused)
                
                CustomTextFieldUIView(text: $viewmodel.titleTehnic, placeHolder: "Название")
                    .focused($nameIsFocused)
                
                CustomTextFieldUIView(text: $viewmodel.noteTehnic, placeHolder: "Примечание")
                    .focused($nameIsFocused)
                
                //MARK: - Add Button
                ButtonView(action: {
                    viewmodel.addTehnic()
                    dismiss()
                }, label: "Добавить технику")
                .offset(y: 40)
            }.padding()
        }.onTapGesture {
            nameIsFocused = false
        }
    }
    
    
}
//MARK: - Preview
#Preview {
    AddTechnicUIView(viewmodel: GarageViewModel(user: DataManager.shared.createTempData()))
}
