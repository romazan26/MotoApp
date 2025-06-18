//
//  CellForSettingsView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 18.06.2025.
//

import SwiftUI

struct CellForSettingsView: View {
        let nameButton: LocalizedStringKey
        let imageName: String
        var red = false
        var body: some View {
            HStack{
                Text(nameButton)
                    .font(.system(size: 45, weight: .bold, design: .monospaced))
                    .minimumScaleFactor(0.5)
                    .foregroundColor(red ? .red : .white)
                Spacer()
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(red ? .red : .white)
                    .padding(.trailing)
            }
            .frame(maxHeight: 60)
            //MARK: - Background
            .padding()
            .background(
                Color.grayApp).cornerRadius(26)
                .overlay {
                    RoundedRectangle(cornerRadius: 26)
                        .stroke(.white, lineWidth: 2.0)
                }
                .shadow(color: .black.opacity(0.15), radius: 8, x: 6, y: 6)
        }
    }


#Preview {
    CellForSettingsView(nameButton: "Rate us", imageName: "star.fill")
}
