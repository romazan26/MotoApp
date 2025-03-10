//
//  CellWorksMain.swift
//  MotoApp
//
//  Created by Роман on 09.12.2024.
//

import SwiftUI

struct CellInfoMainWorksView: View {
    @Environment(\.colorScheme) var colorScheme
    var text: LocalizedStringKey
    var value: String
    var image: String
    var body: some View {
        VStack {
           
                Text(text)
                .fontDesign(.monospaced)
                .font(.system(size: 17))
                    .minimumScaleFactor(0.5)
                
                Image(systemName: image)
                .resizable()
                .frame(width: 14, height: 14)
            
            Divider()
            Text(value)
                .font(.system(size: 18, weight: .bold))
                .minimumScaleFactor(0.5)
        }
        .frame(height: 80)
        .frame(maxWidth: .infinity)
        .padding(8)
        .background {
            Color(colorScheme == .dark ? .white : .black)
                .opacity(0.05)
                .cornerRadius(20)
        }
    }
}

#Preview {
    CellInfoMainWorksView(text: "odometrLabel", value: "15000", image: "speedometer")
        .frame(width: 100)
}
