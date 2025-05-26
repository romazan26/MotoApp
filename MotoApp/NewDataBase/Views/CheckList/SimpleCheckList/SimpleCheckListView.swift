//
//  SimpleCheckListView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 26.05.2025.
//

import SwiftUI

struct SimpleCheckListView: View {
    @StateObject var viewModel: SimpleCheckListViewModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SimpleCheckListView(viewModel: SimpleCheckListViewModel(checkList: Checklist(context: CoreDataManager.instance.context)))
}
