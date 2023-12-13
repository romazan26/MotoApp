//
//  CustomTextFieldUIView.swift
//  MotoApp
//
//  Created by Роман on 30.11.2023.
//

import SwiftUI

struct CustomTextFieldUIView: View {
    @Binding var text: String
    @State var placeHolder = "Name"
    @State private var isTapped = false
    @State var isSecuriti:Bool = false
    
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 4) {
                if !isSecuriti{
                    TextField("", text: $text) { (status) in
                        if status{
                            withAnimation(.easeIn) {
                                isTapped = true
                            }
                        }
                    } onCommit: {
                        if text == "" {
                            withAnimation(.easeOut) {
                                isTapped = false
                            }
                        }
                    }
                    
                    .padding(.top, isTapped ? 15 : 0)
                    .background(alignment: .leading) {
                        Text(placeHolder)
                            .scaleEffect(isTapped ? 0.8 : 1)
                            .offset(x: isTapped ? -7 : 0, y: isTapped ? -15 : 0)
                    }
                  
                }
                else {
                    SecureField("", text: $text) {
                        if text == "" {
                            withAnimation(.easeOut) {
                                isTapped = false
                              
                            }
                        }
                       
                    }
                    .onTapGesture {
                        withAnimation(.easeIn) {
                            isTapped = true
                        }
                    }
                    .padding(.top, isTapped ? 15 : 0)
                    .background(alignment: .leading) {
                        Text(placeHolder)
                            .scaleEffect(isTapped ? 0.8 : 1)
                            .offset(x: isTapped ? -7 : 0, y: isTapped ? -15 : 0)
                    }
                    
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(.orange.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        //.padding()
    }
}

#Preview {

    CustomTextFieldUIView(text: .constant(""))
}
