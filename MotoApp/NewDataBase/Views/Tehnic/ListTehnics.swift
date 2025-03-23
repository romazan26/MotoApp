//
//  ListCoreData.swift
//  MotoApp
//
//  Created by Роман on 26.10.2024.
//

import SwiftUI

struct ListTehnics: View {
    @ObservedObject var vm = CoreDataViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    @State private var animate = false
    var body: some View {
        NavigationStack {
            ZStack {
                Color.grayApp.ignoresSafeArea()
                VStack {
                    //MARK: - Top tool bar
                    HStack{
                        Image(.newLogo)
                            .resizable()
                            .frame(width: 100, height: 100)
                        Spacer()
                        Text("labelTechnicList")
                            .foregroundStyle(.white)
                            .font(.system(size: 30, weight: .bold, design: .serif))
                            .minimumScaleFactor(0.5)
                        
                    }
                    .padding()
                    .background {TopbarBackGroundView(animate: $animate)}
                    .onAppear {
                        self.animate = true
                    }
                    
                    .shadow(color: .black, radius: 15)
                                    
                    ZStack(alignment: .bottomTrailing) {
                        //MARK: - List Tehnics
                        ScrollView {
                            if vm.technics.isEmpty {
                                Text(LocalizedStringKey("emptyListLabel"))
                                    .multilineTextAlignment(.center)
                            }
                            ForEach(vm.technics) { technic in
                                NavigationLink {
                                    WorksMainView(vm: WorkCDViewmodel(technicCD: technic), vmTechnic: vm)
                                } label: {
                                    TechnicCellView(technic: technic)
                                }
                            }
                        }
                        
                        //MARK: - Add tehnic buttom
                        NavigationLink {
                            AddTechnicCDView(vm: vm)
                        } label: {
                            PlusCircleButtonView()
                        }
                        .padding(10)
                    }.padding(.horizontal)
                }
                
                .onAppear(perform: {
                    vm.fetchWorks()
                    vm.fetchTechnic()
                })
            }
        }
    }
}

#Preview {
    ListTehnics()
}
