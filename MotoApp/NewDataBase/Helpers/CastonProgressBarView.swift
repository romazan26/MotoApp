//
//  CastonProgressBarView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 24.02.2025.
//

import SwiftUI

struct CastonProgressBarView: View {
    var progress: Double = 0.99
    var body: some View {
        ZStack {
            Capsule()
                .frame(height: 20)
                .foregroundStyle(.black)
                .opacity(0.5)
                
            ZStack(alignment: .leading){
                Capsule()
                    .frame(height: 5)
                    .padding()
                    .foregroundStyle(.black)
                    .opacity(0.2)
                    .frame(width: 250)
                Capsule()
                    .frame(height: 5)
                    .frame(width: 250 * progress)
                    .padding()
                    .foregroundStyle(.teracot)
            }.frame(width: 250)
        }.frame(width: 290)
    }
}

#Preview {
    CastonProgressBarView()
}
