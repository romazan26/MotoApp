//
//  MainViewModel.swift
//  MotoApp
//
//  Created by Роман Главацкий on 05.05.2025.
//

import Foundation

final class MainViewModel: ObservableObject {
    @Published var currentPage: PageView = .garage
    @Published var isTabBarVisible = true
    
}
