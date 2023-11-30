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
    @Environment(\.dismiss) var dismiss
    @FocusState private var nameIsFocused: Bool
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Image("serii-kirpich-fon")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.5)
            VStack {
                Text("Введите данные о новой технике")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .shadow(color: .blue, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                //MARK: - TextField group
                TextField(text: $typeTehnic) {
                    Text("Тип:").foregroundStyle(.blue)
                        .bold()
                }
                    .customStyle()
                    .focused($nameIsFocused)
                
                TextField(text: $titleTehnic) {
                    Text("Название:").foregroundStyle(.blue)
                        .bold()
                }
                    .customStyle()
                    .focused($nameIsFocused)
                
                TextField(text: $noteTehnic) {
                    Text("Примечание:").foregroundStyle(.blue)
                        .bold()
                }.customStyle()
                
                //MARK: - Add Button
                ButtonView(action: {
                    addTehnic()
                    dismiss()
                }, label: "Добавить технику")
                .offset(y: 40)
            }.padding()
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
