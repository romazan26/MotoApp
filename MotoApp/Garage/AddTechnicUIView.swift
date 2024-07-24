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
            //MARK: - Background
            ZStack{
                Image(.moto)
                    .resizable()
                    .frame(width: 380, height: 220)
                    .offset(y: -30)
                
                BlurUIView(style: .light)
                    .ignoresSafeArea()
                    .opacity(0.9)
            }
            VStack {
                Text("Введите данные о технике")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .shadow(color: .blue, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
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
                
                Spacer()
                
            }.padding()
            
        }
        .onAppear(perform: {
            viewmodel.clear()
        })
        .onTapGesture {
            nameIsFocused = false
        }
    }
    
    
}
//MARK: - Preview
#Preview {
    AddTechnicUIView(viewmodel: GarageViewModel(user: DataManager.shared.createTempData()))
}
