//
//  CellNewItemCheckListView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 25.05.2025.
//

import SwiftUI

struct CellNewItemCheckListView: View {
    let title: String
    let deleteItem: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
                Image(systemName: "circle")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.gray)
                    .shadow(color: .gray.opacity(0.2),
                            radius: 6, x: 2, y: 4)
            
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
            
            Spacer()
            
            Button(action: deleteItem, label: {
                Image(systemName: "xmark")
                    .foregroundStyle(.red)
            })
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.systemGray6))
                .shadow(color: .white.opacity(0.2), radius: 6, x: -4, y: -4)
                .shadow(color: .black.opacity(0.15), radius: 8, x: 6, y: 6)
        )
        .padding(.horizontal, 20)
        .padding(.vertical, 4)
    }
}

#Preview {
    ZStack {
        Color.grayApp.ignoresSafeArea()
        CellNewItemCheckListView(title: "Motobot", deleteItem: {})
    }
}
