//
//  sortWorks.swift
//  MotoApp
//
//  Created by Роман on 10.03.2024.
//

import Foundation
import SwiftUI

enum SortOption: String, CaseIterable{
    case title
    case date
    case price
    
}

extension [Work] {
    func sort(option: SortOption) -> [Work] {
        switch option {
            
        case .title:
            self.sorted(by: {$0.nameWork < $1.nameWork})
        case .date:
            self.sorted(by: {$0.date < $1.date})
        case .price:
            self.sorted(by: {$0.price < $1.price})
        }
    }
}
