//
//  ShadowTextFieldView.swift
//  MotoApp
//
//  Created by Роман on 26.11.2024.
//

import SwiftUI

struct ShadowTextFieldView: View {
    var placeholder: String
    @Binding var text: String
    var body: some View {
        TextField(placeholder, text: $text)
            .lineLimit(0)
            .padding()
            .background(Color.back)
            .clipShape(RoundedRectangle(cornerRadius: 10,style: .continuous))
            .shadow(color: .gray, radius: 8, x: 8, y: 8)
            .shadow(color: .back, radius: 8, x: -8, y: -8)
    }
}

//#Preview {
//    ShadowTextFieldView()
//}
