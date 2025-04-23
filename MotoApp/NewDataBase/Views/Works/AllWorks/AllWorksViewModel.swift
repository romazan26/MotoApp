//
//  AllWorksViewModel.swift
//  MotoApp
//
//  Created by Роман Главацкий on 28.03.2025.
//

import Foundation
import UIKit
import Combine

final class AllWorksViewModel: ObservableObject {
    let technicCD: TechnicCD
    let manager = CoreDataManager.instance
    
    //MARK: - Search propertys
    @Published var searchText: String = ""
    @Published var searchResult: [WorkCD] = []
    @Published private(set) var works: [WorkCD] = []
    @Published private(set) var sortedWorks: [WorkCD] = []
    
    @Published var isPresentInfoWork: Bool = false
    @Published var isPresentEditWork: Bool = false
    @Published var simpleWork: WorkCD?
    
    @Published var selectedSortOption = SortOptionWork.calendar
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(technicCD: TechnicCD) {
        self.technicCD = technicCD
        
        fetchWorks()
        sortWorks()
    }
    
    //MARK: - SortesFunction
    private func sortWorks() {
        $selectedSortOption
            .combineLatest($works)
            .map { selectedSortOption, works in
                switch selectedSortOption {
                case .doc:
                    return works.sorted { ($0.nameWork ?? "") < ($1.nameWork ?? "") }
                case .calendar:
                    return works.sorted { ($0.date ?? Date()) < ($1.date ?? Date()) }
                case .dollarsign:
                    return works.sorted { $0.price < $1.price }
                case .speedometer:
                    return works.sorted { $0.odometr < $1.odometr }
                }
            }
            .combineLatest($searchText.debounce(for: 0.5, scheduler: RunLoop.main))
                    .map { (sortedWorks: [WorkCD], searchText: String) -> [WorkCD] in
                        guard !searchText.isEmpty else { return sortedWorks }
                        return sortedWorks.filter {
                            $0.nameWork?.lowercased().contains(searchText.lowercased()) ?? false
                        }
                    }
                    .receive(on: DispatchQueue.main)
                    .assign(to: \.searchResult, on: self)
                    .store(in: &cancellables)
    }
    
    //MARK: - Punblic method
    func appearAllWork(){
        fetchWorks()
        selectedSortOption = .calendar
    }
    
    func deleteWork(workCD: WorkCD){
        manager.deleteWork(workCD)
        updateWorks()
    }
    
    func updateWorks(){
        works.removeAll()
        fetchWorks()
        searchText.removeAll()
    }
    
    //MARK: - FetchWorks
    private func fetchWorks() {
        if let simpleworks = technicCD.works?.allObjects as? [WorkCD] {
            works = simpleworks
        }
    }
}
