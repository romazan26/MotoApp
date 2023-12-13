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
    @ObservedRealmObject var user: User
    @State private var typeTehnic = ""
    @State private var titleTehnic = ""
    @State private var noteTehnic = ""
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
                CustomTextFieldUIView(text: $typeTehnic, placeHolder: "Тип")
                    .focused($nameIsFocused)
                
                CustomTextFieldUIView(text: $titleTehnic, placeHolder: "Название")
                    .focused($nameIsFocused)
                
                CustomTextFieldUIView(text: $noteTehnic, placeHolder: "Примечание")
                    .focused($nameIsFocused)
                
                //MARK: - Add Button
                ButtonView(action: {
                    addTehnic()
                    dismiss()
                }, label: "Добавить технику")
                .offset(y: 40)
            }.padding()
        }.onTapGesture {
            nameIsFocused = false
        }
    }
    
    //MARK: - add function
    private func addTehnic() {
        let tehnic = Technic()
        tehnic.type = typeTehnic
        tehnic.title = titleTehnic
        tehnic.note = noteTehnic
        $user.technics.append(tehnic)
        typeTehnic = ""
        titleTehnic = ""
        
    }
}
//MARK: - Preview
#Preview {
    AddTechnicUIView(user: DataManager.shared.createTempData())
}
