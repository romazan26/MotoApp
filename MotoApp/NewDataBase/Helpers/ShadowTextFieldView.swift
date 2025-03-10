//
//  ShadowTextFieldView.swift
//  MotoApp
//
//  Created by Роман on 26.11.2024.
//

import SwiftUI

struct ShadowTextFieldView: View {
    var placeholder: LocalizedStringKey
    @Binding var text: String
    var body: some View {
        TextField(placeholder, text: $text)
            .lineLimit(0)
            .padding()
            .background(
                ZStack {
                    // Внешний градиент для выпуклости
                    RoundedRectangle(cornerRadius: 10)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.8),
                                    Color.gray.opacity(0.2)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: -5, y: -5) // Тень для выпуклости
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5) // Тень для углубления
                    
                    // Внутренний фон для TextField
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .padding(2)
                }
            )
    }
}

#Preview {
    ShadowTextFieldView(placeholder: "Enter name", text: .constant(""))
}
