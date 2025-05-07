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
        GeometryReader { geometry in
            let bottomBarHeight = geometry.size.height / 12

            VStack(spacing: 0) {
                Group {
                    switch vm.currentPage {
                    case .checklist:
                        CheckListView()
                    case .settings:
                        SettingsView()
                    case .garage:
                        ListTehnics()
                    }
                }.frame(height: geometry.size.height - bottomBarHeight)
                
                Divider()
                
                HStack(spacing: 40) {
                    ForEach(PageView.allCases, id: \.self) { page in
                        PageIconView(page: page,
                                     selectedPage: vm.currentPage,
                                     width: geometry.size.width/5,
                                     height: geometry.size.height/28)
                            .onTapGesture {vm.currentPage = page}
                    }
                }
                .frame(height: bottomBarHeight)
                .frame(maxWidth: .infinity)
                .background(Color.grayApp)
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    MainView()
}
