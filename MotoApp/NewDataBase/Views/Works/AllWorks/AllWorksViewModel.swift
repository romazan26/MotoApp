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
    @Published var works: [WorkCD] = []
    
    @Published var isPresentInfoWork: Bool = false
    @Published var isPresentEditWork: Bool = false
    @Published var simpleWork: WorkCD?
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(technicCD: TechnicCD) {
        self.technicCD = technicCD
        
        fetchWorks()
        
        $searchText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .combineLatest($works)
            .map { searchText, works in
                if searchText.isEmpty {
                    return works
                }else{
                    return works.filter {
                        $0.nameWork?.lowercased().contains(searchText.lowercased()) ?? false
                    }
                }
            }
            .assign(to: \.self.searchResult, on: self)
            .store(in: &cancellables)
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
    
    func convertDataToImage(_ data: Data?) -> UIImage? {
        guard let data else { return nil }
        return UIImage(data: data)
    }
    
    private func fetchWorks() {
        if let simpleworks = technicCD.works?.allObjects as? [WorkCD] {
            works = simpleworks
        }
    }
}
