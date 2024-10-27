//
//  TehnicView.swift
//  MotoApp
//
//  Created by Роман on 27.10.2024.
//

import SwiftUI

struct TehnicWorksView: View {
    let tehnic: TechnicCD
    @StateObject var vm: CoreDataViewModel
    var body: some View {
        VStack {
            HStack {
                Image(.works)
                    .resizable()
                    .frame(width: 130, height: 100)
                Spacer()
                Text(tehnic.title ?? "")
                    .font(.title)
                Spacer()
            }
            if let works = tehnic.works?.allObjects as? [WorkCD] {
                if works.isEmpty {
                    Text("Нет работ")
                }
                ScrollView {
                    ForEach(works) { work in
                        WorkCellCDView(vm: vm, work: work)
                    }
                }
            }
        }.padding()
        
    }
}

#Preview {
    TehnicWorksView(tehnic: TechnicCD(), vm: CoreDataViewModel())
}
