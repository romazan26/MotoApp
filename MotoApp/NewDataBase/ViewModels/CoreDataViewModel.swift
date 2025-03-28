//
//  CoreDataViewModel.swift
//  MotoApp
//
//  Created by Роман on 27.10.2024.
//

import Foundation
import UIKit
import PhotosUI

@MainActor
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
    @Published var isPresentDeleteAlert: Bool = false
    
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
        let tdoTechinc = TechincTDO(title: titleTehnic,
                                    type: typeTehnic,
                                    note: noteTehnic,
                                    photo: simplePhoto)
        manager.editTechnic(simpleTechnic, tdoTechinc)
        isEditMode = false
        updateTechnics()
        clearTehnic()
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
    func deleteTechnic(technic: TechnicCD){
        manager.deleteTechnic(technic)
        updateTechnics()
    }
    
    //MARK: - Add data
    func addTehnic(){
        let tdoTechinc = TechincTDO(title: titleTehnic,
                                    type: typeTehnic,
                                    note: noteTehnic,
                                    photo: simplePhoto)
        manager.addTechnic(tdoTechinc)
        updateTechnics()
        clearTehnic()
    }
    
    
    //MARK: - Get Data
    func fetchTechnic() {
        Task {
            do {
                technics = try await manager.fetchTechnics()
            } catch {
                print("Ошибка при выполнении запроса: \(error)")
            }
        }
    }
    
    func fetchWorks() {
    Task{
        do {
            works = try await manager.fetchWorks()
        } catch {
            print("Ошибка при выполнении запроса: \(error)")
        }
    }
}
    
    //MARK: - Save in CoreData
    
    private func updateTechnics(){
        technics.removeAll()
        fetchTechnic()
    }
    
    private func updateWorks(){
        works.removeAll()
        fetchWorks()
    }
    
    //MARK: - Clear data
    func clearTehnic(){
        titleTehnic = ""
        typeTehnic = ""
        noteTehnic = ""
        simplePhoto = nil
        isEditMode = false
    }
    
}
