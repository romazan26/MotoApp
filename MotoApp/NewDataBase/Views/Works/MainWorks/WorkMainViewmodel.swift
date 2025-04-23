//
//  TechnicCDViewmodel.swift
//  MotoApp
//
//  Created by Роман on 04.12.2024.
//
import Foundation
import UIKit
import SwiftUI

@MainActor
final class WorkMainViewmodel: ObservableObject{
    let technicCD: TechnicCD
    let manager = CoreDataManager.instance
    
    @Published var works: [WorkCD] = []
    
    //MARK: - Simple propertys
    @Published var simpleShareText: URL?
    
    //MARK: - Present propertys
    @Published var isPresentShareSheet: Bool = false
    @Published var isPresentAllWorks: Bool = false
    @Published var isPresentDeleteAlert: Bool = false
    
    //MARK: - Sortes propertys
    @Published var sortedWorks: [WorkCD] = []
    
    //MARK: - Animation propertyes
    @Published var isFliped: Bool = false
    private var timerForFlipamination: Timer?
    private var isStartedAnimation: Bool = false
    
   
    
    //MARK: - Init
    init(technicCD: TechnicCD) {
        self.technicCD = technicCD
        fetchWorks()
        
    }
    
    //MARK: - Animation function
    func toggleAnimation() {
        if !isStartedAnimation {
            startTimer()
        } else {
            stopTimer()
        }
    }
    
    private func startTimer() {
        guard !isStartedAnimation else { return }
        
        isStartedAnimation = true
        timerForFlipamination = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            withAnimation(.easeInOut(duration: 1.0)) {
                self.isFliped.toggle()
            }
        }
    }
    
    private func stopTimer() {
        timerForFlipamination?.invalidate()
        timerForFlipamination = nil
        isStartedAnimation = false
    }
    
    //MARK: - Share function
    func tapShareButton() {
        guard let fileURL = createTextFile(with: createText()) else {
            print("error creating file")
            return
        }
        simpleShareText = nil
        isPresentShareSheet = true
        simpleShareText = fileURL
    }
    
    private func createTextFile(with text: String) -> URL? {
        let fileManager = FileManager.default
        let tempDirectory = fileManager.temporaryDirectory
        let fileURL = tempDirectory.appendingPathComponent("textFile.txt")
        do {
            try text.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("Failed to create file")
            return nil
        }
        return fileURL
    }
    
    private func createText() -> String {
        var text = "Список работ:\n"
        if let works = technicCD.works?.allObjects as? [WorkCD] {
            for (index, work) in works.enumerated() {
                text += "\nНомер работы: \(index + 1)"
                text += "\n\(work.nameWork ?? "")"
                text += "\nДата: \(work.date ?? Date())"
                text += "\nОдометр: \(work.odometr)\n"
            }
        }
        return text
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
   
    
    //MARK: - Delete data
    
    func deleteTechnic(){
        manager.deleteTechnic(technicCD)
    }
        
     func updateWork() {
        works.removeAll()
        fetchWorks()
    }
    
    
    func fetchWorks() {
        Task {
            do{
                works = try await manager.fetchWorks()
            }catch let error{
                print("error fetchWork:\(error)")
            }
        }
    }
}
