//
//  AddWorkViewModel.swift
//  MotoApp
//
//  Created by Роман Главацкий on 28.03.2025.
//

import Foundation
import UIKit

final class AddWorkViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    let technicCD: TechnicCD
    
    @Published var simpleWork: WorkCD?
    @Published var simpleDate = Date()
    @Published var simpleTitleWork: String = ""
    @Published var simpleOdometer: String = ""
    @Published var simplePrice: String = ""
    
    @Published var isEditorWork: Bool
    
    //MARK: - Init
    init(technicCD: TechnicCD, isEditeWork: Bool, simpleWork: WorkCD?) {
        self.technicCD = technicCD
        self.isEditorWork = isEditeWork
        if isEditeWork {
            getEditWork(editWork: simpleWork)
            self.simpleWork = simpleWork
        }
    }
        
    //MARK: - Add data
    func addWork(){
        let workTdo = WorkTDO(date: simpleDate,
                              title: simpleTitleWork,
                              odometr: Int64(simpleOdometer) ?? 0,
                              price: Int64(simplePrice) ?? 0)
        manager.addWork(workTdo, technicCD)
        clearWork()
    }
    
    //MARK: - Edit data
    func editWork(){

        guard let editWork = simpleWork else {return}
        let workTdo = WorkTDO(date: simpleDate,
                              title: simpleTitleWork,
                              odometr: Int64(simpleOdometer) ?? 0,
                              price: Int64(simplePrice) ?? 0)
        manager.editWork(editWork, workTdo)
        clearWork()
        isEditorWork = false
    }
    
    //MARK: - Feel data
    func getEditWork(editWork: WorkCD?){
        guard let editWork else { return }
            simpleDate = editWork.date ?? Date()
            simpleTitleWork = editWork.nameWork ?? ""
            simpleOdometer = String(editWork.odometr)
            simplePrice = String(editWork.price)
    }
    func convertDataToImage(_ data: Data?) -> UIImage? {
        guard let data else { return nil }
        return UIImage(data: data)
    }
    
    //MARK: - Clear data
    func clearWork(){
        simpleTitleWork = ""
        simpleOdometer = ""
        simplePrice = ""
        simpleDate = Date()
        isEditorWork = false
    }
}
