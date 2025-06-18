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
        HStack{
            if let image = convertDataToImage(technic.photo) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    
            }else{
                Image(.works)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    
            }
            VStack(alignment: .leading) {
                //MARK: - Название техники
                Text("\(technic.title ?? "")")
                    .font(.system(size: 27, weight: .bold, design: .serif))
                    .minimumScaleFactor(0.5)
                
                Spacer()
                Rectangle()
                    .frame(height: 1)
                //MARK: - Count of work
                HStack{
                    Text("countOfWorks")
                    Text("\(technic.works?.count ?? 0)")
                }
                .font(.system(size: 16))
                .minimumScaleFactor(0.5)
            }
        }
        .foregroundStyle(.white)
        .padding()
        .background(
            LinearGradient(
                colors:  [.black.opacity(0.7), .gray.opacity(0.9)],
                startPoint: .bottomLeading,
                endPoint: .topTrailing).cornerRadius(26))
        
        .overlay {
            RoundedRectangle(cornerRadius: 26)
                .stroke(.teracot, lineWidth: 1.0)
        }
        .lineLimit(1)
        .minimumScaleFactor(0.5)
        .bold()
    }
    func convertDataToImage(_ data: Data?) -> UIImage? {
        guard let data else { return nil }
        return UIImage(data: data)
    }
}

