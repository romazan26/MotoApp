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
final class TechnicViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var technics: [TechnicCD] = []
    
    init(){
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
    
    //MARK: - Update data
    
    private func updateTechnics(){
        technics.removeAll()
        fetchTechnic()
    }
}
