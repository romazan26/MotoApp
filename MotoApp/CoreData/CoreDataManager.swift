//
//  CoreDataManager.swift
//  MotoApp
//
//  Created by Роман on 26.10.2024.
//

import CoreData
import Foundation
import UIKit


final class CoreDataManager {
    static let instance = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        // Создаем NSPersistentContainer для новой базы данных
        container = NSPersistentContainer(name: "Garage")
        
        // Добавляем опции для миграции
        if let storeDescription = container.persistentStoreDescriptions.first {
            storeDescription.shouldMigrateStoreAutomatically = true
            storeDescription.shouldInferMappingModelAutomatically = true
            print("migration good")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core Data: \(error.localizedDescription)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        } catch let error {
            print("Save data error: \(error.localizedDescription)")
        }
    }
    //MARK: - Techinc
    func addTechnic(_ tdo: TechincTDO) {
        let newTechnic = TechnicCD(context: context)
        newTechnic.title = tdo.title
        newTechnic.title = tdo.title
        newTechnic.note = tdo.note
        if let photo = tdo.photo {
            newTechnic.photo = convertImageToData(photo)
        }
        save()
    }
    
    func fetchTechnics() async throws -> [TechnicCD] {
        let fetchRequest: NSFetchRequest<TechnicCD> = TechnicCD.fetchRequest()
        return try await context.perform {
            try self.context.fetch(fetchRequest)
        }
    }
    
    func deleteTechnic(_ technic: TechnicCD) {
        context.delete(technic)
        save()
    }
    
    func editTechnic(_ technic: TechnicCD, _ tdo: TechincTDO) {
        technic.title = tdo.title
        technic.note = tdo.note
        technic.type = tdo.type
        technic.photo = tdo.photo.flatMap(convertImageToData)
        save()
    }
    //MARK: - Works
    
    func editWork(_ work: WorkCD, _ wdo: WorkTDO) {
        work.nameWork = wdo.title
        work.date =   wdo.date
        work.odometr = wdo.odometr
        work.price = wdo.price
        save()
    }
    
    func addWork(_ wdo: WorkTDO, _ technic: TechnicCD) {
        let newWork = WorkCD(context: context)
        newWork.nameWork = wdo.title
        newWork.date =   wdo.date
        newWork.odometr = wdo.odometr
        newWork.price = wdo.price
        newWork.techics = technic
        save()
        
    }
    
    func fetchWorks() async throws -> [WorkCD] {
        let fetchRequest: NSFetchRequest<WorkCD> = WorkCD.fetchRequest()
        return try await context.perform {
            try self.context.fetch(fetchRequest)
        }
    }
    
    func deleteWork(_ work: WorkCD) {
        context.delete(work)
        save()
    }
    
    
    func convertImageToData(_ image: UIImage) -> Data? {
        return image.jpegData(compressionQuality: 1.0)
    }
}
