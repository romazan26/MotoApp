//
//  ButtonView.swift
//  MotoApp
//
//  Created by Роман on 10.02.2024.
//

import SwiftUI

struct ButtonView: View {
    @Environment(\.colorScheme) var colorScheme
    let action: () -> Void
    let label: String
    var body: some View {
        Button(action: action, label: {
            Text(label)
                .foregroundStyle(colorScheme == .dark ? .black : .white)
                .font(.title2)
                .bold()
                .minimumScaleFactor(0.5)
                .padding(8)
        })
        .frame(height: 60)
        .background(LinearGradient(
            colors: [colorScheme == .dark ? .white.opacity(0.8) : .black.opacity(0.7), .gray.opacity(0.9)],
            startPoint: .bottomLeading,
            endPoint: .topTrailing))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    ButtonView(action: {}, label: "Hellow")
}
