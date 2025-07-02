//
//  TypeWorkViewModel.swift
//  MotoApp
//
//  Created by Роман Главацкий on 01.07.2025.
//

import Foundation

final class TypeWorkViewModel: ObservableObject {
    @Published var typeWorks: [TypeWork] = []
    @Published var errorMessage: String? = nil
    @Published var newTypeName: String = ""
    @Published var isPresentAddTypeView: Bool = false
    
    let manager = CoreDataManager.instance
    
    init() {
        getTypeWorks()
    }
    
    func getTypeWorks() {
        Task{ @MainActor in
            do{
                typeWorks = try await manager.fetchTypeOfWork()
            }catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func saveNewTypeWork() {
        manager.addNewtype(type: newTypeName)
        newTypeName = ""
        isPresentAddTypeView.toggle()
        getTypeWorks()
    }
    
    func deleteTypework(type: TypeWork){
        manager.deleteTypeOfWork(type)
        getTypeWorks()
    }
}
