//
//  AddAertUIVuew.swift
//  MotoApp
//
//  Created by Роман on 01.12.2023.
//

import SwiftUI


struct AddAertUIVuew: View {
    
    let screenSize = UIScreen.main.bounds
    @Binding var isShow: Bool
    @Binding var text: String
    @Binding var text2: String
    @Binding var text3: String
    @State var place: String
    @State var place2: String
    @State var place3: String

    var title: String = "Add new"
    var onAdd: (String) -> Void = { _ in }
    var onCancel: () -> Void = {}
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .multilineTextAlignment(.center)
                .shadow(color: .blue, radius: 10)
            
            TextField(place, text: $text)
                .textFieldStyle(.roundedBorder)
            TextField(place2, text: $text2)
                .textFieldStyle(.roundedBorder)
            TextField(place3, text: $text3)
                .textFieldStyle(.roundedBorder)
            
            HStack(content: {
                Button("Закрыть") {
                    self.isShow = false
                    self.onCancel()
                    text = ""
                }.buttonStyle(.borderedProminent)
                
                Spacer()
                
                Button("Добавть") {
                    self.isShow = false
                    self.onAdd(self.text)
                }.buttonStyle(.borderedProminent)
            }).padding()
        }
        .padding()
        .frame(width: screenSize.width * 0.7, height: screenSize.height * 0.4)
        .background(.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .offset(y: isShow ? 0 : screenSize.height)
        .animation(.spring(), value: screenSize)
        .shadow(color: .gray, radius: 6, x: -9, y: -9)
    }
}

//#Preview {
//    AddAertUIVuew(isShow: .constant(true), text: .constant(""), text2: .constant(""), text3: .constant(""))
//}
