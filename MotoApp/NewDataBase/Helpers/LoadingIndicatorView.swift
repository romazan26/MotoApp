//
//  LoadingIndicatorView.swift
//  MotoApp
//
//  Created by Роман on 05.12.2024.
//

import SwiftUI

struct LoadingIndicatorView: View {
    @Environment(\.colorScheme) var colorScheme
            var progress: Float = 0.5
            var body: some View {
                ZStack{
                    Circle()
                        .stroke(lineWidth: 2)
                        .foregroundStyle(.gray)
                        .shadow(color: colorScheme == .dark ? .white : .gray, radius: 2)
                    
                    Circle()
                        .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                        .stroke(style: StrokeStyle(lineWidth: 1.5, lineCap: .round, lineJoin: .round))
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                        .rotationEffect(Angle(degrees: 270))
                        
                    
                    Circle()
                        .padding(4)
                        .foregroundStyle(.gray)
                        .shadow(color: colorScheme == .dark ? .white : .black, radius: 2)
                    
                    Text(String(format: "%.0f", progress * 100) + "%")
                        .fontDesign(.monospaced)
                        .foregroundStyle(.white)
                }
                
                .padding()
            }
        
    
}

#Preview {

        LoadingIndicatorView()
            .frame(width: 80, height: 80)
    
}
