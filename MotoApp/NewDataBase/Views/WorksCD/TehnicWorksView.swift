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
    @State var isOpen: Bool = false
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
        VStack {
            
            //MARK: - Technic info
            HStack {
                Image(.works)
                    .resizable()
                    .frame(width: 130, height: 100)
                Spacer()
                Text(tehnic.title ?? "")
                    .font(.title)
                Spacer()
            }
            
            //MARK: - List of works
            if let works = tehnic.works?.allObjects as? [WorkCD] {
                if works.isEmpty {
                    Text("Нет работ")
                    Spacer()
                }else{
                    ScrollView {
                        ForEach(works) { work in
                            WorkCellCDView(vm: vm, work: work)
                        }
                    }
                }
            }
        }
            //MARK: - Add tehnic buttom
            Button {
                isOpen = true
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
            }
            .frame(width: 45, height: 45)
        }
        .padding()
        .sheet(isPresented: $isOpen) {
            AddWorckForTechnicView(tehnic: tehnic, vm: vm)
        }
        
    }
}

#Preview {
    TehnicWorksView(tehnic: TechnicCD(), vm: CoreDataViewModel())
}
