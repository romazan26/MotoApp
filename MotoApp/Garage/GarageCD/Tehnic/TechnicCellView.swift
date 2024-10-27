//
//  TechnicCellView.swift
//  MotoApp
//
//  Created by Роман on 27.10.2024.
//

import SwiftUI

struct TechnicCellView: View {
    @ObservedObject var technic: TechnicCD
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(technic.title ?? "") \(technic.note ?? "")").font(.largeTitle)
            Divider()
            Text("Колличество работ: \(technic.works?.count ?? 0)").font(.footnote)
            Divider()
        }
        .foregroundStyle(colorScheme == .dark ? .black : .white)
        .padding()
        .background(
            LinearGradient(
                colors:  [colorScheme == .dark ? .white.opacity(0.8) : .black.opacity(0.7), .gray.opacity(0.9)],
                startPoint: .bottomLeading,
                endPoint: .topTrailing).cornerRadius(26))
        
        .overlay {
            RoundedRectangle(cornerRadius: 26)
                .stroke(colorScheme == .dark ? .black : .white, lineWidth: 2.0)
        }
        .lineLimit(1)
        .minimumScaleFactor(0.5)
        .bold()
    }
    
}

#Preview {
    TechnicCellView(technic: TechnicCD())
}
