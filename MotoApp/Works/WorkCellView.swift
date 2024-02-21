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
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Название: ")
                    Text(work.nameWork).bold()
                }
                HStack {
                    Text("Одометр: ")
                    Text(String(work.odometr)).bold()
                }
                HStack {
                    Text("Цена:        ")
                    Text(String(work.price)).bold()
                }
                HStack {
                    Text("Дата:        ")
                    Text(String(work.date.formatted(date: .numeric, time: .shortened)))
                }
            }
            Spacer()
            Image(systemName: "pencil.line")
                .resizable()
                .frame(width: 50, height: 50)
        }.foregroundStyle(.black)
    }
}

#Preview {
    WorkCellView(work: Work())
}
