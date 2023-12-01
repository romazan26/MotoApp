//
//  WorksUIView.swift
//  MotoApp
//
//  Created by Роман on 01.12.2023.
//

import SwiftUI
import RealmSwift

struct WorksUIView: View {
    @ObservedRealmObject var technis: Technic
    
    var body: some View {
        VStack {
            if technis.works.isEmpty {
                Text("Нет выполненных работ")
            }
            List {
                ForEach(technis.works) { work in
                    VStack(alignment: .leading) {
                        Text(work.nameWork)
                        Text(String(work.odometr))
                        Text(String(work.price))
                        //Text(String(work.date))
                    }
                }
            }
            ButtonView(action: {
                
            }, label: "Добавить работу")
        }
    }
}

#Preview {
    WorksUIView(technis: DataManager.shared.createTempDataTechic())
}
