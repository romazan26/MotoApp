//
//  TechnicCDViewmodel.swift
//  MotoApp
//
//  Created by Роман on 04.12.2024.
//
import Foundation
import CoreData
import UIKit
import SwiftUI
import Combine

final class WorkCDViewmodel: ObservableObject{
    let technicCD: TechnicCD
    let manager = CoreDataManager.instance
    
    @Published var works: [WorkCD] = []
    
    //MARK: - Simple propertys
    @Published var simpleWork: WorkCD?
    @Published var simpleDate = Date()
    @Published var simpleTitleWork: String = ""
    @Published var simpleOdometer: String = ""
    @Published var simplePrice: String = ""
    @Published var simpleShareText: URL?
    
    //MARK: - Present propertys
    @Published var isPresentInfoWork: Bool = false
    @Published var isEditorWork: Bool = false
    @Published var isPresentEditWork: Bool = false
    @Published var isPresentShareSheet: Bool = false
    @Published var isPresentAllWorks: Bool = false
    
    //MARK: - Sortes propertys
    @Published var sortedWorks: [WorkCD] = []
    @Published var selectedSortOption = SortOptionWork.calendar {
        didSet {
            sortedWorks = sortingWorks()
        }
    }
    
    //MARK: - Animation propertyes
    @Published var isFliped: Bool = false
    private var timerForFlipamination: Timer?
    private var isStartedAnimation: Bool = false
    
    //MARK: - Search propertys
    @Published var searchText: String = ""
    @Published var searchResult: [WorkCD] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    //MARK: - Init
    init(technicCD: TechnicCD) {
        self.technicCD = technicCD
        fetchWorks()
        selectedSortOption = SortOptionWork.calendar
        
        $searchText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .combineLatest($sortedWorks)
            .map { searchText, sortedWorks in
                if searchText.isEmpty {
                    return sortedWorks
                }else{
                    return sortedWorks.filter {
                        $0.nameWork?.lowercased().contains(searchText.lowercased()) ?? false
                    }
                }
            }
            .assign(to: \.self.searchResult, on: self)
            .store(in: &cancellables)
    }
    
    func convertDataToImage(_ data: Data?) -> UIImage? {
        guard let data else { return nil }
        return UIImage(data: data)
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
    
    //MARK: - SortesFunction
    func sortingWorks() -> [WorkCD] {
        if let works = technicCD.works?.allObjects as? [WorkCD]{
            switch selectedSortOption {
             
            case .doc:
                return works.sorted(by: {$0.nameWork ?? "" < $1.nameWork ?? ""})
            case .calendar:
                return works.sorted(by: {$0.date ?? Date() < $1.date ?? Date()})
            case .dollarsign:
                return works.sorted(by: {$0.price < $1.price})
            case .speedometer:
                return works.sorted(by: {$0.odometr < $1.odometr})
            }
        }
        return []
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
    
    //MARK: - Edit data
    func editWork(){
        simpleWork?.nameWork = simpleTitleWork
        simpleWork?.odometr = Int64(simpleOdometer) ?? 0
        simpleWork?.price = Int64(simplePrice) ?? 0
        simpleWork?.date = simpleDate
        saveWork()
        clearWork()
        isEditorWork = false
        selectedSortOption = .calendar
    }
    
    //MARK: - Feel data
    func getEditWork(){
        if let editWork = simpleWork{
            simpleDate = editWork.date ?? Date()
            simpleTitleWork = editWork.nameWork ?? ""
            simpleOdometer = String(editWork.odometr)
            simplePrice = String(editWork.price)
            isEditorWork = true
        }
    }
    
    //MARK: - Delete data
    func deleteWork(work: WorkCD){
        manager.context.delete(work)
        saveWork()
        selectedSortOption = SortOptionWork.calendar
    }
    
    func deleteTechnic(){
        if let works = technicCD.works?.allObjects as? [WorkCD] {
            for work in works {
                deleteWork(work: work)
            }
        }
        manager.context.delete(technicCD)
        manager.save()
    }
    
    //MARK: - Add data
    func addWork(){
        let newWork = WorkCD(context: manager.context)
        newWork.nameWork = simpleTitleWork
        newWork.odometr = Int64(simpleOdometer) ?? 0
        newWork.price = Int64(simplePrice) ?? 0
        newWork.date = simpleDate
        newWork.techics = technicCD
        saveWork()
        clearWork()
        selectedSortOption = .calendar
    }
    
    func clearWork(){
        simpleTitleWork = ""
        simpleOdometer = ""
        simplePrice = ""
        simpleDate = Date()
        isEditorWork = false
    }
    func saveWork() {
        works.removeAll()
        manager.save()
        fetchWorks()
    }
    func fetchWorks() {
        let request = NSFetchRequest<WorkCD>(entityName: "WorkCD")
        do {
            works = try manager.context.fetch(request)
        } catch {
            print(error)
        }
    }
}
