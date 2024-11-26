//
//  TehnicView.swift
//  MotoApp
//
//  Created by Роман on 27.10.2024.
//

import SwiftUI

struct TehnicWorksView: View {
    
    let technic: TechnicCD
    @ObservedObject var vm: CoreDataViewModel
    @State var isOpen: Bool = false
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
        VStack {
            
            //MARK: - Technic info
            HStack {
                Image(.works)
                    .resizable()
                    .frame(width: 130, height: 100)
                VStack(alignment: .leading) {
                    Text("\(technic.title ?? "")")
                    Text("Одометр: \(vm.getFinalOdometry(technic: technic))")
                    Text("Колличество работ: \(vm.getCountWorks(technic: technic))")
                    Text("Потрачено: \(vm.getFinalPrice(technic: technic))")
                }
            Spacer()
            }
            .minimumScaleFactor(0.5)
            
            //MARK: - List of works
            if let works = technic.works?.allObjects as? [WorkCD] {
                if works.isEmpty {
                    Text("Нет работ")
                    Spacer()
                }else{
                    ScrollView {
                        ForEach(works) { work in
                            NavigationLink {
                                
                                WorkViewCD(work: work, technic: technic, vm: vm)
                            } label: {
                                WorkCellCDView(vm: vm, work: work)
                            }   
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
                    .foregroundStyle(colorScheme != .dark ? .black : .white)
            }
            .frame(width: 45, height: 45)
        }
        .padding()
        .sheet(isPresented: $isOpen) {
            AddWorckForTechnicView(tehnic: technic, vm: vm)
        }
        .toolbar {
            //MARK: - Delete technic button
            ToolbarItem {
                Button {
                    vm.deleteTechnic(technic: technic)
                    dismiss()
                } label: {
                    Text("Удалить \(technic.title ?? "")")
                        .foregroundStyle(.red)
                }

            }
        }
    }
}

#Preview {
    TehnicWorksView(technic: TechnicCD(), vm: CoreDataViewModel())
}
