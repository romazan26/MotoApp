//
//  GradientButtonView.swift
//  MotoApp
//
//  Created by Роман on 26.11.2024.
//

import SwiftUI

struct GradientButtonView: View {
    var label: LocalizedStringKey
    var color: Color = .red
    var body: some View {
        
        Text(label)
            .foregroundStyle(.white)
            .font(.title2)
            .bold()
            .minimumScaleFactor(0.5)
            .padding(8)
        
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(LinearGradient(
                colors: [color, .gray.opacity(0.9)],
                startPoint: .bottomLeading,
                endPoint: .topTrailing))
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    GradientButtonView(label: "addTechinbuttonLabel")
}
