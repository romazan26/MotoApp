//
//  TehnicView.swift
//  MotoApp
//
//  Created by Роман on 27.10.2024.
//

import SwiftUI

struct TehnicWorksView: View {

    @ObservedObject var vm: WorkCDViewmodel
    @State var isOpen: Bool = false
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
        VStack {
            
            //MARK: - Technic info
            TechnicInfoView(vm: vm)
            
            //MARK: - List of works
           
                    ScrollView {
                        ForEach(vm.sortedWorks) { work in
                            NavigationLink {
                                WorkViewCD(work: work, vm: vm)
                            } label: {
                                WorkCellCDView(work: work)
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
            AddWorckForTechnicView(vm: vm)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu("Сортировать") {
                    Picker("", selection: $vm.selectedSortOption) {
                        ForEach(SortOptionWork.allCases, id: \.rawValue) { option in
                            Label(option.rawValue, systemImage: "\(option)")
                                .tag(option)
                        }
                    }
                    .labelsHidden()
                }
            }
        }
    }
}

//#Preview {
//    TehnicWorksView(technic: TechnicCD(), vm: CoreDataViewModel())
//}
