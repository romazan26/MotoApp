//
//  CellCheckListView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 26.05.2025.
//

import SwiftUI

struct CellCheckListView: View {
    let nameCheckList: String
    let countCheckListItem: Int
    var body: some View {
        HStack{
            Text(nameCheckList)
                .font(.system(size: 20, weight: .bold, design: .monospaced))
                .foregroundColor(.white)
            Spacer()
            Text("\(countCheckListItem)")
                .font(.system(size: 17, weight: .bold, design: .default))
                .foregroundColor(.white)
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
    ZStack {
        Color.grayApp
        CellCheckListView(nameCheckList: "In horn", countCheckListItem: 5)
    }
}
