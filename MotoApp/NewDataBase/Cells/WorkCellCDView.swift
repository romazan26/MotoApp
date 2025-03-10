//
//  WorkCellCDView.swift
//  MotoApp
//
//  Created by Роман on 27.10.2024.
//

import SwiftUI

struct WorkCellCDView: View {
    @ObservedObject var work: WorkCD
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                //MARK: - Name of work
                Text(work.nameWork ?? "")
                    .font(.system(size: 22, weight: .heavy, design: .serif))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.black)
                
                //MARK: - Odometr of work
                HStack{
                    Text("odometrLabel")
                    Text("\(String(work.odometr))")
                }
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.black)
                .opacity(0.6)
                
                //MARK: - Date of work
                HStack{
                    Text("dateLabel")
                    Text(":  \(Dateformatter(date: work.date ?? Date()))")
                }
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.black)
                .opacity(0.6)
                
            }
            
            .padding()
            Spacer()
        }
        .minimumScaleFactor(0.5)
        
        //MARK: - Background of cell work
        .background(
            Color.grayApp).cornerRadius(26)
        
            .overlay {
                RoundedRectangle(cornerRadius: 26)
                    .stroke(.white, lineWidth: 2.0)
            }.shadow(radius: 3)
    }
    //MARK: - Dateformatter
    private func Dateformatter(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d  MMMM  yyyy"
        return dateFormatter.string(from: date)
    }
}

#Preview {
    ZStack {
        Color.grayApp
        WorkCellCDView( work: WorkCD(context: CoreDataManager.instance.context)  )
    }
}
