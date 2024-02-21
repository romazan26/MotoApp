//
//  BackgroundCustom.swift
//  MotoApp
//
//  Created by Роман on 21.02.2024.
//

import SwiftUI

struct BackgroundCustom: View {
    var body: some View {
        ZStack{
            Image(.moto)
                .resizable()
                .frame(width: 380, height: 220)
                .offset(y: -30)
            
            BlurUIView(style: .light)
                .ignoresSafeArea()
                .opacity(0.8)
        }
    }
}

#Preview {
    BackgroundCustom()
}
