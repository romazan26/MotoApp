//
//  ButtonView.swift
//  MotoApp
//
//  Created by Роман on 10.02.2024.
//

import SwiftUI

struct ButtonView: View {
    let action: () -> Void
    let label: String
    var body: some View {
        Button(action: action, label: {
            Text(label)
                .foregroundStyle(.white)
                .font(.title2)
                .bold()
        })
        .frame(width: 160, height: 60)
        .background(LinearGradient(
            colors: [.black.opacity(0.7), .gray.opacity(0.9)],
            startPoint: .bottomLeading,
            endPoint: .topTrailing))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    ButtonView(action: {}, label: "Hellow")
}
