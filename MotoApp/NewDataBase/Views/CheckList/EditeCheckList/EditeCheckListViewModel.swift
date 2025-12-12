//
//  EditeCheckListViewModel.swift
//  MotoApp
//
//  Created by Роман Главацкий on 18.11.2025.
//

import Combine
import Foundation

final class EditeCheckListViewModel: ObservableObject {
    
    private let manager = CoreDataManager.instance
    
    @Published var editList: Checklist
    
    @Published var titleCheckList: String = ""
    @Published var titleItem: String = ""
    @Published var items: [String] = []
    @Published var itemsCheckList: [ItemCheck] = []
    
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    init(editList: Checklist) {
        self.editList = editList
        loadData(chekList: editList)
    }
    var canAddItem: Bool {
        !titleItem.isEmpty
    }
    
    
    
    private func loadData(chekList: Checklist) {
        titleCheckList = chekList.title ?? ""
        if let items = chekList.item?.allObjects as? [ItemCheck] {
            self.itemsCheckList = items
        }
    }
    
    func deleteOldItem(item: ItemCheck){
        manager.deleteItemCheck(item)
        loadData(chekList: editList)
    }
    
    func deleteItem(at index: Int) {
        items.remove(at: index)
    }
    
    func addNewItem() {
        guard canAddItem else { return }
        items.append(titleItem)
        titleItem = ""
    }
    
    func saveEditingCheckList(completion: @escaping () -> Void)  {
        isLoading = true
        errorMessage = nil
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            do{
                
                
                for item in items {
                    let newItem = ItemCheckTDO(completed: false, title: item)
                    self.manager.addItemCheck(newItem, to: editList)
                }
                let tdo: CheckListTDO = CheckListTDO(completed: false, title: titleCheckList)
                manager.editCheckList(editList, tdo: tdo)
                DispatchQueue.main.async {
                    self.isLoading = false
                    completion()
                }
            }
        }
        
    }
}
