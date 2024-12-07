//
//  TechnicCDViewmodel.swift
//  MotoApp
//
//  Created by Роман on 04.12.2024.
//
import Foundation
import CoreData

final class WorkCDViewmodel: ObservableObject{
    let technicCD: TechnicCD
    let manager = CoreDataManager.instance
    
    @Published var works: [WorkCD] = []
    @Published var simpleWork: WorkCD?
    @Published var simpleDate = Date()
    @Published var simpleTitleWork: String = ""
    @Published var simpleOdometer: String = ""
    @Published var simplePrice: String = ""
    @Published var isEditorWork: Bool = false
    @Published var isPresentEditWork: Bool = false
    
    @Published var sortedWorks: [WorkCD] = []
    @Published var selectedSortOption = SortOptionWork.calendar {
        didSet {
            sortedWorks = sortingWorks()
        }
    }
    
    init(technicCD: TechnicCD) {
        self.technicCD = technicCD
        fetchWorks()
        selectedSortOption = SortOptionWork.calendar
    }
    
    //MARK: - SortesFunction
    func sortingWorks() -> [WorkCD] {
        if let works = technicCD.works?.allObjects as? [WorkCD]{
            switch selectedSortOption {
             
            case .doc:
                return works.sorted(by: {$0.nameWork ?? "" < $1.nameWork ?? ""})
            case .calendar:
                return works.sorted(by: {$0.date ?? Date() < $1.date ?? Date()})
            case .dollarsign:
                return works.sorted(by: {$0.price < $1.price})
            case .speedometer:
                return works.sorted(by: {$0.odometr < $1.odometr})
            }
        }
        return []
    }
    
    //MARK: - Get info data
    func getFinalOdometry() -> String{
        var maxodometr: Int64 = 0
        if let works = technicCD.works?.allObjects as? [WorkCD], !works.isEmpty{
            maxodometr = works.max(by: { $0.odometr < $1.odometr })?.odometr ?? 0
        }
        return String(maxodometr)
    }
    
    func getCountWorks() -> String{
        var countWorks: Int = 0
        if let works = technicCD.works?.allObjects as? [WorkCD], !works.isEmpty{
            countWorks = works.count
        }
        return String(countWorks)
    }
    
    func getFinalPrice() -> String{
        var finalPrice: Int64 = 0
        if let works = technicCD.works?.allObjects as? [WorkCD], !works.isEmpty{
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
        clearWork()
        isEditorWork = false
        selectedSortOption = .calendar
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
        selectedSortOption = SortOptionWork.calendar
    }
    
    func deleteTechnic(){
        if let works = technicCD.works?.allObjects as? [WorkCD] {
            for work in works {
                deleteWork(work: work)
            }
        }
        manager.context.delete(technicCD)
        manager.save()
    }
    
    //MARK: - Add data
    func addWork(){
        let newWork = WorkCD(context: manager.context)
        newWork.nameWork = simpleTitleWork
        newWork.odometr = Int64(simpleOdometer) ?? 0
        newWork.price = Int64(simplePrice) ?? 0
        newWork.date = simpleDate
        newWork.techics = technicCD
        saveWork()
        clearWork()
        selectedSortOption = .calendar
    }
    
    func clearWork(){
        simpleTitleWork = ""
        simpleOdometer = ""
        simplePrice = ""
        simpleDate = Date()
    }
    func saveWork() {
        works.removeAll()
        manager.save()
        fetchWorks()
    }
    func fetchWorks() {
        let request = NSFetchRequest<WorkCD>(entityName: "WorkCD")
        do {
            works = try manager.context.fetch(request)
        } catch {
            print(error)
        }
    }
}
