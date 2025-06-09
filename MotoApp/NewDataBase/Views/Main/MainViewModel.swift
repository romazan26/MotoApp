//
//  MainViewModel.swift
//  MotoApp
//
//  Created by Роман Главацкий on 05.05.2025.
//

import Foundation

final class MainViewModel: ObservableObject {
    @Published var currentPage: PageView = .garage
    
    let tabItems = [
        TabItem(icon: "house.fill", title: "Home"),
        TabItem(icon: "magnifyingglass", title: "Search"),
        TabItem(icon: "person.fill", title: "Profile")
    ]
}
