//
//  WorksViewModel.swift
//  MotoApp
//
//  Created by Роман on 09.01.2024.
//

import Foundation
import RealmSwift
import SwiftUI

final class WorksViewModel: ObservableObject {
    
    @ObservedRealmObject var technic: Technic
    
    @Published var simpleNamework = ""
    @Published var simpleOdometr = ""
    @Published var simplePrice = ""
    
    @Published var isPresentedNewWorkView = false

    @Published var selectedSortOption = SortOptionWork.calendar
    
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
    
    //MARK: Fill in the data
    func fillData(id: ObjectId) {
        
        do {
            let realm = try Realm()
            guard let objectToUpdate = realm.object(ofType: Work.self, forPrimaryKey: id) else {return}
                 simpleNamework = objectToUpdate.nameWork
                 simpleOdometr = String(objectToUpdate.odometr)
                 simplePrice = String(objectToUpdate.price)
        }
        catch {
            print("error update")
        }
    
    }
    
    //MARK: - Clear data
    func clear(){
        simpleNamework = ""
        simpleOdometr = ""
        simplePrice = ""
    }
    
    //MARK: - Add function
    func addWork() {
        if !simpleNamework.isEmpty{
            let work = Work()
            work.nameWork = simpleNamework
            work.odometr = Int(simpleOdometr) ?? 0
            work.price = Int(simplePrice) ?? 0
            work.date = Date.now
            $technic.works.append(work)
        }
        clear()
    }
    
    //MARK: - Update work function
    
    
    func upDataWork(id: ObjectId) {
        print("name: \(simpleNamework)")
            do {
                let realm = try Realm()
                guard let objectToUpdate = realm.object(ofType: Work.self, forPrimaryKey: id) else {
                    return}
                try realm.write {

                        objectToUpdate.nameWork = simpleNamework
                        objectToUpdate.odometr = Int(simpleOdometr) ?? 0
                        objectToUpdate.price = Int(simplePrice) ?? 0
                }
            }
            catch {
                print("error update")
            }
        clear()
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
    
    //MARK: Final Price
    func finalPrice() -> Int {
        var finalPrice = 0
        for work in sortWork {
            finalPrice += work.price
        }
        return finalPrice
    }
    
    //MARK: Find Odometr
    func findOdometr() -> Int {
        var odomet = 0
        for work in sortWork {
            if work.odometr > odomet {
                odomet = work.odometr
            }
        }
        return odomet
    }
}
