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
                CustomTopBarView(barText: "settingsLabel")
                Spacer()
            }
        }
    }
}

#Preview {
    SettingsView()
}
