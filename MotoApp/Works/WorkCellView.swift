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
                    HStack {
                        Text("Название: ")
                        Text(work.nameWork).bold()
                    }
                    Divider()
                    HStack {
                        Text("Одометр: ")
                        Text(String(work.odometr)).bold()
                    }
                    Divider()
                    HStack {
                        Text("Цена:        ")
                        Text(String(work.price)).bold()
                    }
                    Divider()
                    HStack {
                        Text("Дата:        ")
                        Text(String(work.date.formatted(date: .numeric, time: .shortened)))
                    }
                    
                }
                Spacer()
                Image(systemName: "pencil.line")
                    .resizable()
                    .frame(width: 50, height: 50)
                    
            }
            .padding(3)
        .foregroundStyle(.black)
            Divider().background(.red).shadow(color: .red, radius: 0.9)
        }
    }
}


#Preview {
    WorkCellView(work: Work())
}
