//
//  PageView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 05.05.2025.
//

enum PageView: CaseIterable {
    case garage
    case checklist
    case settings
    
    var title: String {
        switch self {
        case .garage:
            return "Гараж"
        case .checklist:
            return "Чеклист"
        case .settings:
            return "Настройки"
        }
    }
    
    var imageName: String {
        switch self {
        case .garage:
            return "door.garage.closed"
        case .checklist:
            return "checklist"
        case .settings:
            return "gearshape"
        }
    }
}
