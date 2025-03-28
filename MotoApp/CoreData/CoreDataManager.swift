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
        
        // Загружаем хранилище
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core Data: \(error.localizedDescription)")
            }
        }
        
        // Устанавливаем контекст
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
