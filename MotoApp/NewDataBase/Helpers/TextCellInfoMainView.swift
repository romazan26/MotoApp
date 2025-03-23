//
//  TextCellInfoMainView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 22.03.2025.
//

import SwiftUI

struct TextCellInfoMainView: View {
    var text: LocalizedStringKey
    
    var body: some View {
        VStack {
                Text(text)
                .multilineTextAlignment(.center)
                .fontDesign(.monospaced)
                .font(.system(size: 20, weight: .bold))
                    .minimumScaleFactor(0.5)
                   
        }
        .frame(height: 80)
        .frame(maxWidth: .infinity)
        .padding(8)
        .background {
            Color(.black)
                .shadow(color: .teracot, radius: 1)
                .opacity(0.05)
                .cornerRadius(20)
        }
        
    }
}

#Preview {
    TextCellInfoMainView(text: "seeAllButton")
}
