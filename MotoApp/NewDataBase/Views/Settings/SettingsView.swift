//
//  SettingsView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 07.05.2025.
//

import SwiftUI

struct SettingsView: View {
    @State private var animate = false
    var body: some View {
        ZStack {
            Color.grayApp.ignoresSafeArea()
            VStack {
                //MARK: - Top tool bar
                HStack {
                    Image(.newLogo)
                        .resizable()
                        .frame(width: 100, height: 100)
                    Spacer()
                    Text("settingsLabel")
                        .foregroundStyle(.white)
                        .font(.system(size: 30, weight: .bold, design: .serif))
                        .minimumScaleFactor(0.5)
                    Spacer()
                }
                .padding()
                .background { TopbarBackGroundView(animate: $animate) }
                .onAppear { self.animate = true }
                .shadow(color: .black, radius: 15)
                Spacer()
            }
        }
    }
}

#Preview {
    SettingsView()
}
