//
//  ListCoreData.swift
//  MotoApp
//
//  Created by Роман on 26.10.2024.
//

import SwiftUI

struct ListCoreData: View {
    @StateObject var vm: CoreDataViewModel
    var body: some View {
        VStack {
            Text("Список техники (Новая база)")
                .font(.title)
            ZStack(alignment: .bottomTrailing) {
                //MARK: - List Tehnics
                ScrollView {
                    ForEach(vm.technics) { technic in
                        NavigationLink {
                            TehnicWorksView(tehnic: technic, vm: vm)
                        } label: {
                            TechnicCellView(technic: technic)
                        }
                    }
                }
                
                //MARK: - Add tehnic buttom
                NavigationLink {
                    AddTechnicView(vm: vm)
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                }
                .frame(width: 45, height: 45)


            }
           
            
        }
        .onAppear(perform: {
            vm.fetchWorks()
            vm.fetchTechnic()
        })
        .padding()
        
    }
}

#Preview {
    ListCoreData(vm: CoreDataViewModel())
}
