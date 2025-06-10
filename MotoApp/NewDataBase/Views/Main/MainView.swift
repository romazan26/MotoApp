//
//  MainView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 05.05.2025.
//

import SwiftUI

struct MainView: View {
    @StateObject var vm = MainViewModel()

    var body: some View {
        
        ZStack(alignment: .bottom) {
            switch vm.currentPage {
            case .checklist:
                CheckListView()
            case .settings:
                SettingsView()
            case .garage:
                ListTehnics()
            }
            
            CustomTabBar(selectPage: $vm.currentPage, isVisible: $vm.isTabBarVisible, views: PageView.allCases)
        }
    }
}

#Preview {
    MainView()
}
