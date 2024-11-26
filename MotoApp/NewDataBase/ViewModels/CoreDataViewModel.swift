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
    @Published var simpleWork: WorkCD?
    @Published var simpleDate = Date()
    @Published var simpleTitleWork: String = ""
    @Published var simpleOdometer: String = ""
    @Published var simplePrice: String = ""
    @Published var isEditorWork: Bool = false
    @Published var isPresentEditWork: Bool = false
    
    init(){
        fetchWorks()
        fetchTechnic()
    }
    
    //MARK: - Get info data
    func getFinalOdometry(technic: TechnicCD) -> String{
        var maxodometr: Int64 = 0
        if let works = technic.works?.allObjects as? [WorkCD], !works.isEmpty{
            maxodometr = works.max(by: { $0.odometr < $1.odometr })?.odometr ?? 0
        }
        return String(maxodometr)
    }
    
    func getCountWorks(technic: TechnicCD) -> String{
        var countWorks: Int = 0
        if let works = technic.works?.allObjects as? [WorkCD], !works.isEmpty{
            countWorks = works.count
        }
        return String(countWorks)
    }
    
    func getFinalPrice(technic: TechnicCD) -> String{
        var finalPrice: Int64 = 0
        if let works = technic.works?.allObjects as? [WorkCD], !works.isEmpty{
            finalPrice = works.reduce(0) { $0 + $1.price }
        }
        return String(finalPrice)
    }
    
    //MARK: - Edit data
    func editWork(){
        simpleWork?.nameWork = simpleTitleWork
        simpleWork?.odometr = Int64(simpleOdometer) ?? 0
        simpleWork?.price = Int64(simplePrice) ?? 0
        simpleWork?.date = simpleDate
        saveWork()
        isEditorWork = false
    }
    
    //MARK: - Feel data
    func getEditWork(work: WorkCD){
        simpleWork = work
        simpleDate = work.date ?? Date()
        simpleTitleWork = work.nameWork ?? ""
        simpleOdometer = String(work.odometr)
        simplePrice = String(work.price)
        isEditorWork = true
    }
    
    //MARK: - Delete data
    func deleteWork(work: WorkCD){
        manager.context.delete(work)
        saveWork()
    }
    
    func deleteTechnic(technic: TechnicCD){
        if let works = technic.works?.allObjects as? [WorkCD] {
            for work in works {
                deleteWork(work: work)
            }
        }
        manager.context.delete(technic)
        saveTechnic()
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

