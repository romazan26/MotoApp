//
//  GarageViewModel.swift
//  MotoApp
//
//  Created by Роман on 08.01.2024.
//

import Foundation
import RealmSwift
import CoreData


final class GarageViewModel: ObservableObject {
    
   let defaults = UserDefaults.standard
    
    
    //MARK: - CoreData
    let manager = CoreDataManager.instance
    
    @Published var coreDataActive: Bool = false
    
    @Published var technicsCD: [TechnicCD] = []
    @Published var workCD: [WorkCD] = []
    
    //MARK: Delete everything from the CoreData
    func deleteAll() {
        for technic in technicsCD {
            if let works = technic.works?.allObjects as? [WorkCD] {
                for work in works {
                    manager.context.delete(work)
                    saveTechnic()
                }
                
            }
            manager.context.delete(technic)
            saveTechnic()
        }
        print("technicsCD deleted: \(technicsCD)")
        defaults.set(false, forKey: "coreDataActive")
        coreDataActive = false
    }
    
    //MARK: Get CoreData
    func fetchTechnic() {
        let requestT = NSFetchRequest<TechnicCD>(entityName: "TechnicCD")
        do {
            technicsCD = try manager.context.fetch(requestT)
        } catch {
            print(error)
        }
    }
    func fetchWorks() {
        let requestW = NSFetchRequest<WorkCD>(entityName: "WorkCD")
        do {
            workCD = try manager.context.fetch(requestW)
        } catch {
            print(error)
        }
    }
    
    //MARK: Load in core data
    func addTechnic(note: String, title: String, type: String, workRealm: List<Work>) {
        let newTechnic = TechnicCD(context: manager.context)
        newTechnic.note = note
        newTechnic.title = title
        newTechnic.type = type
        for work in workRealm {
            addWork(nameWork: work.nameWork, odometr: work.odometr, technic: newTechnic, date: work.date, price: work.price)
        }
        saveTechnic()
    }
    
    func addWork(nameWork: String, odometr: Int, technic: TechnicCD, date: Date, price: Int) {
        let newWork = WorkCD(context: manager.context)
        newWork.nameWork = nameWork
        newWork.odometr = Int64(odometr)
        newWork.price = Int64(price)
        newWork.date = date
        newWork.techics = technic
        saveWork()
    }
    
    
    func loadData() {
        for technic in user.technics {
            let works = technic.works
            addTechnic(note: technic.note, title: technic.title, type: technic.type, workRealm: works)
        }
        print(technicsCD)
        print("finish load")
        coreDataActive = true
        defaults.set(true, forKey: "coreDataActive")
    }
    
    //MARK: Save in CoreData
    
    func saveTechnic() {
        technicsCD.removeAll()
        manager.save()
        fetchTechnic()
    }
    
    func saveWork() {
        workCD.removeAll()
        manager.save()
        fetchWorks()
    }
    
    //MARK: - Realm
    @ObservedRealmObject var user: User
    
    init(user: User) {
        self.user = user
        fetchWorks()
        fetchTechnic()
        coreDataActive = defaults.bool(forKey: "coreDataActive")
    }
    var technics: List<Technic> {
        user.technics
    }
    var garage: String {
        user.garageName
    }
    var lastTechnicId: ObjectId {
        guard let id = user.technics.last?.id else {return ObjectId()}
        return id
    }
    
    @Published var typeTehnic = ""
    @Published var titleTehnic = ""
    @Published var noteTehnic = ""
    @Published var isPresented = false
 
    
    //MARK: - Clear data
    func clear(){
        typeTehnic = ""
        titleTehnic = ""
        noteTehnic = ""
    }
    
    //MARK: - addTechnic function
     func addTehnic() {
        let tehnic = Technic()
        tehnic.type = typeTehnic
        tehnic.title = titleTehnic
        tehnic.note = noteTehnic
        
        $user.technics.append(tehnic)
        typeTehnic = ""
        titleTehnic = ""
        
    }
    
}
