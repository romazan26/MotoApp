//
//  CheckListViewModel.swift
//  MotoApp
//
//  Created by Роман Главацкий on 12.05.2025.
//

import Foundation


final class CheckListViewModel: ObservableObject {
    private let manager: CoreDataManager
    
    @Published var checkList: [Checklist] = []
    @Published var error: Error?
    
    init(manager: CoreDataManager = .instance) {
        self.manager = manager
        Task { await fetchCheckList() }
    }
    
    @MainActor
    private func fetchCheckList() async {
        do {
            checkList = try await manager.fetchCheckLists()
            error = nil
        } catch {
            print("Fetch checkList Error: \(error)")
            self.error = error
            checkList = [] 
        }
    }
    
    func getCountItem(list: Checklist) -> Int {
        if let items = list.item?.allObjects as? [ItemCheck]{
            return items.count
        }else {
            return 0
        }
    }
    
    func updateCheckList(){
        Task { await fetchCheckList() }
    }
    
    func checkAllItem(list: Checklist) -> Bool {
        var answer: Bool = false
        if let items = list.item?.allObjects as? [ItemCheck]{
            var countTrue: Int = 0
            for item in items {
                if item.completed == true {
                    countTrue += 1
                }
            }
            if countTrue == items.count {
                answer = true
            }
        }
        return answer
    }
}
