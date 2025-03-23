//
//  TopbarBackGroundView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 22.03.2025.
//

import SwiftUI

struct TopbarBackGroundView: View {
    @Binding var animate: Bool
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [animate ? Color.grayApp : Color.black.opacity(0.2), animate ? Color.black.opacity(0.1) : Color.grayApp]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animate)
    }
}

#Preview {
    TopbarBackGroundView(animate: .constant(true))
}
