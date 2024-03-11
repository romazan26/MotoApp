//
//  WorksViewModel.swift
//  MotoApp
//
//  Created by Роман on 09.01.2024.
//

import Foundation
import RealmSwift

final class WorksViewModel: ObservableObject {
    
    @ObservedRealmObject var technic: Technic
    
    @Published var nameWork = ""
    @Published var odonetr = ""
    @Published var price = ""
    @Published var isPresentedAlert = false
    @Published var isPresentedAlertEdite = false
    @Published var workToEdite = Work()
    @Published var selectedSortOption = SortOptionWork.calendar
   // @Published var sortWork: [Work] = []
    
    var sortWork: [Work] {
        sortedWorks()
        
    }
    
    init(technic: Technic) {
        self.technic = technic
    }
    
    var lastWorkId: ObjectId {
        guard let id = technic.works.last?.id else {return ObjectId()}
        return id
    }
    
    //MARK: - Add function
    func addWork() {
        if !nameWork.isEmpty{
            let work = Work()
            work.nameWork = nameWork
            work.odometr = Int(odonetr) ?? 0
            work.price = Int(price) ?? 0
            work.date = Date.now
            $technic.works.append(work)
        }
        nameWork = ""
        odonetr = ""
        price = ""
    }
    
    //MARK: - Update work function
    func upDateWork() {
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
    
    //MARK: - SortesFunction
    func sortedWorks() -> [Work] {
        var sortedarray: [Work] = []
        switch selectedSortOption {
         
        case .doc:
            sortedarray = self.technic.works.sorted(by: {$0.nameWork < $1.nameWork})
        case .calendar:
            sortedarray = self.technic.works.sorted(by: {$0.date < $1.date})
        case .dollarsign:
            sortedarray = self.technic.works.sorted(by: {$0.price < $1.price})
        case .speedometer:
            sortedarray = self.technic.works.sorted(by: {$0.odometr < $1.odometr})
        }
        return sortedarray
    }
}
