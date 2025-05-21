//
//  CustomTopBarView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 21.05.2025.
//

import SwiftUI

struct CustomTopBarView: View {
    var barImage: UIImage?
    var barText: LocalizedStringKey?
    var titleUp = ""
    var titleDown = ""
    var titleDown2 = ""
    var body: some View {
        HStack {
            Image(uiImage: barImage ?? .newLogo)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            if let localizedStringKey = barText {
                Text(localizedStringKey)
                    .foregroundStyle(.white)
                    .font(.system(size: 30, weight: .bold, design: .serif))
                    .minimumScaleFactor(0.5)
                    .padding(.horizontal)
            }else{
                VStack(alignment: .leading) {
                    
                    Text(titleUp)
                        .foregroundStyle(.white)
                        .font(.system(size: 28, weight: .bold, design: .serif))
                        .minimumScaleFactor(0.5)
                                       
                    HStack {
                        Text(titleDown)
                            .foregroundStyle(.white)
                            .minimumScaleFactor(0.5)
                        Text(titleDown2)
                            .foregroundStyle(.white)
                            .minimumScaleFactor(0.5)
                    }
                }.padding(.horizontal)
            }
            Spacer()
        }
        .padding()
        .background { TopbarBackGroundView() }
        .shadow(color: .black, radius: 15)
    }
}

#Preview {
    CustomTopBarView( barText: nil)
}
