//
//  SimpleCheckListViewMadel.swift
//  MotoApp
//
//  Created by Роман Главацкий on 26.05.2025.
//

import Foundation

final class SimpleCheckListViewModel: ObservableObject {
    let checkList: Checklist
    
    init(checkList: Checklist) {
        self.checkList = checkList
    }
}
