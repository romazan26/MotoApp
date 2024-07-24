//
//  WorkCellView.swift
//  MotoApp
//
//  Created by Роман on 21.02.2024.
//

import SwiftUI

struct WorkCellView: View {
    @Environment(\.colorScheme) var colorScheme
    let work: Work
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(work.nameWork)
                    .font(.system(size: 30, weight: .heavy, design: .serif))
                Text("одометр: \(String(work.odometr))").bold()
                Text("Цена: \(String(work.price))").bold()
                Text("Дата: \(String(work.date.formatted()))")
            }
            .foregroundStyle(colorScheme == .dark ? .black : .white)
            .padding()
            Spacer()
        }
        .minimumScaleFactor(0.5)
        .background(
            LinearGradient(
                colors:  [colorScheme == .dark ? .white.opacity(0.8) : .black.opacity(0.7), .gray.opacity(0.9)],
                startPoint: .bottomLeading,
                endPoint: .topTrailing).cornerRadius(26))
        
        .overlay {
            RoundedRectangle(cornerRadius: 26)
                .stroke(colorScheme == .dark ? .black : .white, lineWidth: 2.0)
        }
        
        
        
    }
}

#Preview {
    WorkCellView(work: Work())
}
