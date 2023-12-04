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

    @State private var nameWork = ""
    @State private var odonetr = ""
    @State private var isPresentedAlert = false
    
    
    var body: some View {
        ZStack {
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
                AddAertUIVuew(isShow: $isPresentedAlert, text: $nameWork, title: "Add Work") { text in
                    nameWork = text
                    addWork()
                }
                ButtonView(action: {
                    isPresentedAlert.toggle()
                }, label: "Добавить работу")
            }
        }
    }
    
    func addWork() {
        let work = Work()
        work.nameWork = nameWork
        work.odometr = Int(odonetr) ?? 0
        $technis.works.append(work)
    }
}

#Preview {
    WorksUIView(technis: DataManager.shared.createTempDataTechic())
}
