//
//  Background2025View.swift
//  MotoApp
//
//  Created by Роман Главацкий on 03.07.2025.
//

import SwiftUI

struct Background2025View: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Rectangle()
                    .foregroundStyle(.bluapp)
                    .frame(width: geo.size.width, height: geo.size.height * 0.7)
                    .offset(y: geo.size.height * 0.4)
                Image(systemName: "house.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(1.8)
                    .foregroundStyle(.bluapp)
                VStack {
                    Image(.gearBack)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        
                    Text("My Garage")
                        .foregroundStyle(.white)
                        .font(.system(size: geo.size.height * 0.05, weight: .bold, design: .monospaced))
                }
                .frame(height: geo.size.height * 0.25)
                .offset(y: geo.size.height * -0.05)
                
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .position(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY * 0.6)
        }
    }
}

#Preview {
    Background2025View()
}
