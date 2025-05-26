//
//  CellWorksMain.swift
//  MotoApp
//
//  Created by Роман on 09.12.2024.
//

import SwiftUI

struct CellInfoMainWorksView: View {

    var text: LocalizedStringKey
    var value: String
    var image: String
    
    var body: some View {
        VStack {
                Text(text)
                .fontDesign(.monospaced)
                .font(.system(size: 25))
                    .minimumScaleFactor(0.5)
                
                Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Divider()
            Text(value)
                .font(.system(size: 25, weight: .bold))
                .minimumScaleFactor(0.5)
        }
        .padding(8)
        .background {
            Color(.black)
                .opacity(0.05)
                .cornerRadius(20)
        }
    }
}

#Preview {
    CellInfoMainWorksView(text: "odometrLabel", value: "15000", image: "speedometer")
        .frame(width: 200, height: 200)
}
