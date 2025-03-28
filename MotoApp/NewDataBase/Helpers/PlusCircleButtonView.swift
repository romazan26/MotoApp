//
//  PlusCircleButtonView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 25.02.2025.
//

import SwiftUI

struct PlusCircleButtonView: View {
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(.darkGrayApp)
                .overlay(
                    Circle()
                        .stroke(Color.teracot.opacity(0.8), lineWidth: 4)
                        .blur(radius: 5)
                        .mask(Circle())
                )
            Image(systemName: "plus")
                
                .resizable()
                .foregroundStyle(.white)
                .frame(width: 39, height: 39)
        }.frame(width: 76, height: 76)
    }
}

#Preview {
    PlusCircleButtonView()
}
