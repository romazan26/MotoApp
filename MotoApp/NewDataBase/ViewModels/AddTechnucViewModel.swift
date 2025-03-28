//
//  AddTechnucViewModel.swift
//  MotoApp
//
//  Created by Роман Главацкий on 28.03.2025.
//

import Foundation
import UIKit
import PhotosUI

final class AddTechnucViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var titleTehnic: String = ""
    @Published var typeTehnic: String = ""
    @Published var noteTehnic: String = ""
    @Published var simplePhoto: UIImage?
    @Published var simpleTechnic: TechnicCD?
    
    @Published var isEditMode: Bool
    @Published var isPresentPhotoPicker: Bool = false
    
    //MARK: - Photo picker configuration
    var config: PHPickerConfiguration {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        config.selectionLimit = 1
        
        return config
    }
    init(isEditMode: Bool, technic: TechnicCD?) {
        self.isEditMode = isEditMode
        if isEditMode {
            tapOfEdit(technic: technic)
        }
    }
    
    
    //MARK: - Helpers
    func tapOfEdit(technic: TechnicCD?){
        guard let technic else { return }
        simpleTechnic = technic
        titleTehnic = technic.title ?? ""
        typeTehnic = technic.type ?? ""
        noteTehnic = technic.note ?? ""
        simplePhoto = convertDataToImage(technic.photo)
        isEditMode = true
    }
    
    private func convertDataToImage(_ data: Data?) -> UIImage? {
        guard let data else { return nil }
        return UIImage(data: data)
    }
    
    //MARK: - Add data
    func addTehnic(){
        let tdoTechinc = TechincTDO(title: titleTehnic,
                                    type: typeTehnic,
                                    note: noteTehnic,
                                    photo: simplePhoto)
        manager.addTechnic(tdoTechinc)
        clearTehnic()
    }
    
    //MARK: - Edit techinc
    func saveEdit(){
        guard let simpleTechnic else { return }
        let tdoTechinc = TechincTDO(title: titleTehnic,
                                    type: typeTehnic,
                                    note: noteTehnic,
                                    photo: simplePhoto)
        manager.editTechnic(simpleTechnic, tdoTechinc)
        isEditMode = false
        clearTehnic()
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
