//
//  AddCheckListViewModel.swift
//  MotoApp
//
//  Created by Роман Главацкий on 21.05.2025.
//

import Foundation

final class AddCheckListViewModel: ObservableObject {
    private let manager = CoreDataManager.instance
    
    @Published var titleCheckList: String = ""
    @Published var titleItem: String = ""
    @Published var items: [String] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    var canAddCheckList: Bool {
        !titleCheckList.isEmpty && !items.isEmpty
    }
    
    var canAddItem: Bool {
        !titleItem.isEmpty
    }
    
    func addNewItem() {
        guard canAddItem else { return }
        items.append(titleItem)
        titleItem = ""
    }
    
    func deleteItem(at index: Int) {
        items.remove(at: index)
    }
    
    func clearSimpleData() {
        titleCheckList = ""
        items = []
    }
    
    func addNewCheckList(completion: @escaping () -> Void)  {
       guard canAddCheckList else {
           errorMessage = "Please enter a title and at least one item"
           return
       }
        
        isLoading = true
        errorMessage = nil
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            do{
                let newCheckList = manager.addCheckList(CheckListTDO(completed: false, title: titleCheckList))
                
                for item in items {
                    let newItem = ItemCheckTDO(completed: false, title: item)
                    self.manager.addItemCheck(newItem, to: newCheckList)
                }
                
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.clearSimpleData()
                    completion()
                }
            }
        }
    }
}
