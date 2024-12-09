//
//  WorkCellCDView.swift
//  MotoApp
//
//  Created by Роман on 27.10.2024.
//

import SwiftUI

struct WorkCellCDView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var work: WorkCD
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                //MARK: - Name of work
                Text(work.nameWork ?? "")
                    .font(.system(size: 30, weight: .heavy, design: .serif))
                    .multilineTextAlignment(.leading)
                
                //MARK: - Odometr of work
                HStack{
                    Text("odometrLabel")
                    Text("\(String(work.odometr))")
                }.bold()
                
                //MARK: - Date of work
                HStack{
                    Text("dateLabel")
                    Text(": \(Dateformatter(date: work.date ?? Date()))")
                }
                
            }
            .foregroundStyle(colorScheme == .dark ? .black : .white)
            .padding()
            Spacer()
        }
        .minimumScaleFactor(0.5)
        
        //MARK: - Background of cell work
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
    //MARK: - Dateformatter
    private func Dateformatter(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d.M.yyyy"
        return dateFormatter.string(from: date)
    }
}

