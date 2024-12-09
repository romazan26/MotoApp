//
//  MiniWorkCellView.swift
//  MotoApp
//
//  Created by Роман on 09.12.2024.
//

import SwiftUI

struct MiniWorkCellView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var work: WorkCD
    
    var body: some View {
        Text(work.nameWork ?? "")
            .minimumScaleFactor(0.5)
            .fontWeight(.bold)
            .frame(width: 100, height: 60)
            .padding(8)
            .background {
                Color(colorScheme == .dark ? .white : .black)
                    .opacity(0.05)
                    .cornerRadius(20)
            }
    }
}

//#Preview {
//    MiniWorkCellView(work: WorkCD())
//}
