//
//  CoreDataViewModel.swift
//  MotoApp
//
//  Created by Роман on 27.10.2024.
//

import CoreData
import Foundation
import UIKit
import PhotosUI

final class CoreDataViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var technics: [TechnicCD] = []
    @Published var works: [WorkCD] = []
    
    //MARK: - Technic propertyes
    @Published var titleTehnic: String = ""
    @Published var typeTehnic: String = ""
    @Published var noteTehnic: String = ""
    @Published var simplePhoto: UIImage?
    @Published var simpleTechnic: TechnicCD?
    
    @Published var isEditMode: Bool = false
    @Published var isPresentPhotoPicker: Bool = false
    
    //MARK: - Photo picker configuration
    var config: PHPickerConfiguration {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        config.selectionLimit = 1
        
        return config
    }
    
    init(){
        fetchWorks()
        fetchTechnic()
    }
    
    
    //MARK: - Edit data
    
    func saveEdit(){
        guard let simpleTechnic else { return }
        simpleTechnic.title = titleTehnic
        simpleTechnic.type = typeTehnic
        simpleTechnic.note = noteTehnic
        if let photo = simplePhoto {
            simpleTechnic.photo = convertImageToData(photo)
        }
        isEditMode = false
        saveTechnic()
    }
    
    func tapOfEdit(technic: TechnicCD){
        simpleTechnic = technic
        titleTehnic = technic.title ?? ""
        typeTehnic = technic.type ?? ""
        noteTehnic = technic.note ?? ""
        simplePhoto = convertDataToImage(technic.photo)
        isEditMode = true
    }
    
    //MARK: - Converting data
    func convertImageToData(_ image: UIImage) -> Data? {
        return image.jpegData(compressionQuality: 1.0)
    }
    func convertDataToImage(_ data: Data?) -> UIImage? {
        guard let data else { return nil }
        return UIImage(data: data)
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
        if let photo = simplePhoto{
            newTechnic.photo = convertImageToData(photo)
        }
        saveTechnic()
        clearTehnic()
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
    
}
