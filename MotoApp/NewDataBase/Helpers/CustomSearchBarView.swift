//
//  CustomSearchBarView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 22.03.2025.
//

import SwiftUI

struct CustomSearchBarView: View {
    let title: LocalizedStringKey
    @Binding var text: String
    var body: some View{
        HStack{
            TextField(title, text: $text)
                
            Button {
                text = ""
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.gray)
            }

        }
        .padding()
                .frame(height: 55)
                
                .background (.white, in:
                        RoundedRectangle(cornerRadius: 14).stroke(lineWidth: 2)
               )
                .font(.system(size: 18))
                .minimumScaleFactor(0.5)

    }
}

#Preview {
    CustomSearchBarView(title: "Placeholder", text: .constant(""))
}
