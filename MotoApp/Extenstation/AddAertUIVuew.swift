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
    
    @FocusState private var keyboardIsFocused: Bool

    var title: String = "Add new"
    var onAdd: (String) -> Void = { _ in }
    var onCancel: () -> Void = {}
    
    var body: some View {
        ZStack {
            BlurUIView(style: .systemUltraThinMaterialDark)
                .ignoresSafeArea()
                .opacity(0.8)
                .offset(y: isShow ? 0 : screenSize.height)
                .animation(.spring(), value: isShow)
            VStack {
                Text(title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .shadow(color: .gray, radius: 10)
                    .padding()
                
                TextField(place, text: $text)
                    .textFieldStyle(.roundedBorder)
                    .focused($keyboardIsFocused)
                TextField(place2, text: $text2)
                    .textFieldStyle(.roundedBorder)
                    .focused($keyboardIsFocused)
                
                if !place3.isEmpty{
                    TextField(place3, text: $text3)
                        .textFieldStyle(.roundedBorder)
                        .focused($keyboardIsFocused)
                }
                
                HStack(content: {
                    Button("Закрыть") {
                        self.isShow = false
                        self.onCancel()
                        text = ""
                    }.buttonStyle(.borderedProminent)
                    
                    Spacer()
                    
                    Button("Сохранить") {
                        self.isShow = false
                        self.onAdd(self.text)
                        keyboardIsFocused = false
                        
                    }.buttonStyle(.borderedProminent)
                }).padding(.vertical)
            }
            .minimumScaleFactor(0.5)
            .padding()
            .frame(width: screenSize.width * 0.7, height: screenSize.height * 0.4)
            .background(BlurUIView(style: .light))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .offset(y: isShow ? 0 : screenSize.height)
            .animation(.spring(), value: isShow)
            .onTapGesture {
                keyboardIsFocused = false
        }
        }
    }
}

#Preview {
    AddAertUIVuew(isShow: .constant(true), text: .constant("Change"), text2: .constant(""), text3: .constant(""), place: "", place2: "odometr", place3: "price")
}
