//
//  SettingsViewModel.swift
//  MotoApp
//
//  Created by Роман Главацкий on 18.06.2025.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    @Published var isPresentedDeleteAlert: Bool = false
    
    private let policyURLString = "https://doc-hosting.flycricket.io/garage/dd98cc84-fe96-4b2e-9d24-cdfa44717337/privacy"
    private let manager = CoreDataManager.instance
    let policyURL: URL

    init() {
        guard let url = URL(string: policyURLString) else {
                   fatalError("Invalid URL: \(policyURLString)")
               }
               self.policyURL = url
    }
    
    func clearData() {
        manager.deleteAllData()
    }
}
