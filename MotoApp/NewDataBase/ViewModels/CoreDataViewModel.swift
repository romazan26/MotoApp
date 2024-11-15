//
//  CoreDataViewModel.swift
//  MotoApp
//
//  Created by Роман on 27.10.2024.
//

import CoreData
import Foundation

final class CoreDataViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var technics: [TechnicCD] = []
    @Published var works: [WorkCD] = []
    
    //MARK: - Technic propertyes
    @Published var titleTehnic: String = ""
    @Published var typeTehnic: String = ""
    @Published var noteTehnic: String = ""
    
    //MARK: - Works propertyes
    @Published var simpleDate = Date()
    @Published var simpleTitleWork: String = ""
    @Published var simpleOdometer: String = ""
    @Published var simplePrice: String = ""
    
    init(){
        fetchWorks()
        fetchTechnic()
    }
    
    //MARK: - Add data
    func addTehnic(){
        let newTechnic = TechnicCD(context: manager.context)
        newTechnic.title = titleTehnic
        newTechnic.type = typeTehnic
        newTechnic.note = noteTehnic
        saveTechnic()
        clearTehnic()
    }
    
    func addWork(technic: TechnicCD){
        let newWork = WorkCD(context: manager.context)
        newWork.nameWork = simpleTitleWork
        newWork.odometr = Int64(simpleOdometer) ?? 0
        newWork.price = Int64(simplePrice) ?? 0
        newWork.date = simpleDate
        newWork.techics = technic
        saveWork()
        clearWork()
    }
    
    //MARK: - Get Data
    func fetchTechnic() {
        let request = NSFetchRequest<TechnicCD>(entityName: "TechnicCD")
        do {
            technics = try manager.context.fetch(request)
        } catch {
            print(error)
        }
    }
    func fetchWorks() {
        let request = NSFetchRequest<WorkCD>(entityName: "WorkCD")
        do {
            works = try manager.context.fetch(request)
        } catch {
            print(error)
        }
    }
    
    //MARK: - Save in CoreData
    
    func saveTechnic() {
        technics.removeAll()
        manager.save()
        fetchTechnic()
    }
    
    func saveWork() {
        works.removeAll()
        manager.save()
        fetchWorks()
    }
    
    //MARK: - Clear data
    func clearTehnic(){
        titleTehnic = ""
        typeTehnic = ""
        noteTehnic = ""
    }
    
    func clearWork(){
        simpleTitleWork = ""
        simpleOdometer = ""
        simplePrice = ""
        simpleDate = Date()
    }
}

