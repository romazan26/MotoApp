//
//  ListCoreData.swift
//  MotoApp
//
//  Created by Роман on 26.10.2024.
//

import SwiftUI

struct ListCoreData: View {
    @ObservedObject var vm = CoreDataViewModel()
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationStack {
            VStack {
                Text("labelTechnicList")
                    .font(.largeTitle)
                ZStack(alignment: .bottomTrailing) {
                    //MARK: - List Tehnics
                    ScrollView {
                        ForEach(vm.technics) { technic in
                            NavigationLink {
                                TehnicWorksView(technic: technic, vm: vm)
                            } label: {
                                TechnicCellView(technic: technic)
                            }
                        }
                    }
                    
                    //MARK: - Add tehnic buttom
                    NavigationLink {
                        AddTechnicCDView(vm: vm)
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .foregroundStyle(colorScheme != .dark ? .black : .white)
                    }
                    .frame(width: 45, height: 45)
                }
            }
            .padding()
            .onAppear(perform: {
                vm.fetchWorks()
                vm.fetchTechnic()
            })
        }
    }
}

#Preview {
    ListCoreData()
}
