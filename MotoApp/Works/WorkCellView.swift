//
//  WorkCellView.swift
//  MotoApp
//
//  Created by Роман on 21.02.2024.
//

import SwiftUI

struct WorkCellView: View {
    
    let work: Work
    
    var body: some View {
        
        VStack {
            HStack {
                VStack(alignment: .leading) {
                        Text(work.nameWork).bold()
                    .lineLimit(2)
                    Divider()
                    HStack {
                        Text("Одометр:")
                        Spacer()
                        Text(String(work.odometr)).bold()
                    }.lineLimit(1)
                    Divider()
                    HStack {
                        Text("Цена:")
                        Spacer()
                        Text(String(work.price)).bold()
                            
                    }.lineLimit(1)
                    Divider()
                    HStack {
                        Text("Дата:")
                        Spacer()
                        Text(String(work.date.formatted(date: .numeric, time: .shortened)))
                    }.lineLimit(1)
                    
                }
                    
            }
            .padding(3)
        .foregroundStyle(.black)
            Divider().background(.red).shadow(color: .red, radius: 0.9)
        }
        .minimumScaleFactor(0.5)
    }
}


#Preview {
    WorkCellView(work: Work())
}
