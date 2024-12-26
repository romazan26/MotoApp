//
//  CoreDataManager.swift
//  MotoApp
//
//  Created by Роман on 26.10.2024.
//

import CoreData
import Foundation

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
}
