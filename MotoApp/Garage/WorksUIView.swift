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

    private let screenSize = UIScreen.main.bounds
    
    @State private var nameWork = ""
    @State private var odonetr = ""
    @State private var price = ""
    @State private var isPresentedAlert = false
    @State private var isPresentedAlertEdite = false
    @State private var workToEdite = Work()
    
    
    //MARK: - Body
    var body: some View {
        ZStack {
                if technis.works.isEmpty {
                    Text("Нет выполненных работ")
                }
                //MARK: - Works name
                List {
                    ForEach(technis.works) { work in
                        Group {
                            HStack {
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
                                Spacer()
                               
                                Button(action: {
                                    workToEdite = work
                                    isPresentedAlertEdite.toggle()
                                    
                                        
                                }) {
                                    Image(systemName: "pencil.line")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                }
                            }
                        }

                        .listRowBackground( LinearGradient(
                            colors: [.orange, .blue.opacity(0.7)],
                            startPoint: .bottomLeading,
                            endPoint: .topTrailing).opacity(0.4))
                        
                        
                    }.onDelete(perform: $technis.works.remove)
                        
                }
                .background(LinearGradient(
                    colors: [.orange, .blue.opacity(0.8)],
                    startPoint: .bottomLeading,
                    endPoint: .topTrailing).opacity(0.6))
                .scrollContentBackground(.hidden)
                
                //MARK: - Add Button
                ButtonView(action: {
                    isPresentedAlert.toggle()
                }, label: "Добавить работу")
                .offset(x: screenSize.width - 300, y: screenSize.height - 550)
            
            
            //MARK: - Show Alert add
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
            
            //MARK: - Show Alert edite
            AddAertUIVuew(
                isShow: $isPresentedAlertEdite,
                text: $nameWork,
                text2: $odonetr,
                text3: $price,
                place: "Название работы",
                place2: "Одометр",
                place3: "Цена",
                title: "Редактировать") { text in
                nameWork = text
                upDateWork()
            }
        }
    }
    //MARK: - Add function
    func addWork() {
        if !nameWork.isEmpty{
            let work = Work()
            work.nameWork = nameWork
            work.odometr = Int(odonetr) ?? 0
            work.price = Int(price) ?? 0
            work.date = Date.now
            $technis.works.append(work)
        }
        nameWork = ""
        odonetr = ""
        price = ""
    }
    
    //MARK: - Update work function
    func upDateWork() {
        print(nameWork)
            do {
                let realm = try Realm()
                guard let objectToUpdate = realm.object(ofType: Work.self, forPrimaryKey: workToEdite.id) else {
                    return}
                try realm.write {
                    objectToUpdate.nameWork = nameWork
                    objectToUpdate.odometr = Int(odonetr) ?? 0
                    objectToUpdate.price = Int(price) ?? 0
                    
                }
            }
            catch {
                print("error update")
            }
            
            
        }
    
}
//MARK: - Preview
#Preview {
    WorksUIView(technis: DataManager.shared.createTempDataTechic())
}
