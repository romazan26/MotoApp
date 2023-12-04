//
//  WorksUIView.swift
//  MotoApp
//
//  Created by Роман on 01.12.2023.
//

import SwiftUI
import RealmSwift

struct WorksUIView: View {
    //MARK: - Propety
    @ObservedRealmObject var technis: Technic
    
    @State private var nameWork = ""
    @State private var odonetr = ""
    @State private var price = ""
    @State private var isPresentedAlert = false
    
    //MARK: - Body
    var body: some View {
        ZStack {
            VStack {
                if technis.works.isEmpty {
                    Text("Нет выполненных работ")
                }
                //MARK: - Text list Works
                List {
                    ForEach(technis.works) { work in
                        NavigationLink {
                            Text("Work")
                        } label: {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("название: ")
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
                        }

                        
                    }
                }
                //MARK: - Add Button
                ButtonView(action: {
                    isPresentedAlert.toggle()
                }, label: "Добавить работу")
            }
            //MARK: - Add Alert
            AddAertUIVuew(
                isShow: $isPresentedAlert,
                text: $nameWork,
                text2: $odonetr,
                text3: $price,
                place: "Название работы",
                place2: "Одометр",
                place3: "Цена",
                title: "Новая работа") { text in
                nameWork = text
                addWork()
            }
        }
    }
    //MARK: - Add function
    func addWork() {
        let work = Work()
        work.nameWork = nameWork
        work.odometr = Int(odonetr) ?? 0
        work.price = Int(price) ?? 0
        work.date = Date.now
        $technis.works.append(work)
    }
}
//MARK: - Preview
#Preview {
    WorksUIView(technis: DataManager.shared.createTempDataTechic())
}
