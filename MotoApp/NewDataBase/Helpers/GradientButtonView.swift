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
    
    @State private var animate = false
    
    var body: some View {
        
        Text(label)
            .foregroundStyle(.white)
            .font(.system(size: 25, weight: .bold, design: .serif))
            .minimumScaleFactor(0.5)
            .padding(8)
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background {
                LinearGradient(gradient: Gradient(colors: [animate ? Color.grayApp : color, animate ? Color.black.opacity(0.3) : Color.grayApp]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                    .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animate)
            }
            .onAppear {
                self.animate = true
            }
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    GradientButtonView(label: "addTechinbuttonLabel")
}
