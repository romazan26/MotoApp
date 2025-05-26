//
//  PlusButtonOneItemView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 21.05.2025.
//

import SwiftUI

struct PlusButtonOneItemView: View {
    var height: CGFloat = 60
    var body: some View {
        ZStack {
            Image(systemName: "plus")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(12)
                .foregroundStyle(.teracot)
            
        }
        .frame(height: height)
        .frame(maxWidth: .infinity)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.teracot, lineWidth: 2.0)
        }
    }
}

#Preview {
    PlusButtonOneItemView()
}
