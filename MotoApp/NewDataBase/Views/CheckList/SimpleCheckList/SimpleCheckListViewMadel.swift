//
//  SimpleCheckListViewMadel.swift
//  MotoApp
//
//  Created by Роман Главацкий on 26.05.2025.
//

import Foundation
import Combine
import SwiftUI

final class SimpleCheckListViewModel: ObservableObject {
    var checkList: Checklist
    let manager = CoreDataManager.instance
    
    @Published var items: [ItemCheck] = []
    @Published var isPresentDeleteAlert: Bool = false
    @Published var checkListTitle: String = ""
    
    init(checkList: Checklist) {
        self.checkList = checkList
        gettingItems()
    }
    
     func gettingItems() {
         // Обновляем объект из контекста CoreData
         manager.context.refresh(checkList, mergeChanges: true)
         checkListTitle = checkList.title ?? ""
         if let itemsData = checkList.item?.allObjects as? [ItemCheck] {
             items = itemsData
         }else{
             items = []
         }
    }
    
    func updateCheckList() {
        gettingItems()
    }
    
    func completeItem(item: ItemCheck) {
        var itemTDO = ItemCheckTDO(completed: false, title: item.title ?? "")
        if item.completed {
           itemTDO = ItemCheckTDO(completed: false, title: item.title ?? "")
        }else {
            itemTDO = ItemCheckTDO(completed: true, title: item.title ?? "")
        }
        manager.editItemCheck(item, tdo: itemTDO)
        gettingItems()
    }
    
    func deleteCheckList() {
        manager.deleteCheckList(checkList)
    }
    
    func resetCheckList() {
        for item in items {
            let itemTDO = ItemCheckTDO(completed: false, title: item.title ?? "")
            manager.editItemCheck(item, tdo: itemTDO)
        }
        gettingItems()
    }
}
