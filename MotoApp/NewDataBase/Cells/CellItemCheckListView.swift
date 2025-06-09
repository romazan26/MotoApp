//
//  CellItemCheckListView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 29.05.2025.
//

import SwiftUI

struct CellItemCheckListView: View {
    let nameItem: String
    let complited: Bool
    var body: some View {
        HStack{
            Text(nameItem)
                .font(.system(size: 20, weight: .bold, design: .monospaced))
                .foregroundColor(.white)
            Spacer()
            Image(systemName: complited ? "checkmark.circle.fill" : "circle")
                .foregroundColor(complited ? .green : .white)
                .padding(.trailing)
        }
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
    CellItemCheckListView(nameItem: "Мото боты", complited: true)
}
