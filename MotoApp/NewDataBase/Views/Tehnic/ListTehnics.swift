//
//  ListCoreData.swift
//  MotoApp
//
//  Created by Роман on 26.10.2024.
//

import SwiftUI

struct ListTehnics: View {
    @ObservedObject var vm = TechnicViewModel()
    @Environment(\.colorScheme) var colorScheme

    @State private var animate = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.grayApp.ignoresSafeArea()

                VStack(spacing: 0) {
                    //MARK: - Top tool bar
                    CustomTopBarView(barText: "labelTechnicList")

                    //MARK: - List for technics
                    GeometryReader { geo in
                        ZStack(alignment: .bottomTrailing) {
                            ScrollView {
                                if vm.technics.isEmpty {
                                    Text(LocalizedStringKey("emptyListLabel"))
                                        .multilineTextAlignment(.center)
                                        .frame(height: geo.size.height)
                                        .minimumScaleFactor(0.5)
                                } else {
                                    VStack(spacing: 12) {
                                        ForEach(vm.technics) { technic in
                                            NavigationLink {
                                                WorksMainView(vm: WorkMainViewmodel(technicCD: technic))
                                            } label: {
                                                TechnicCellView(technic: technic)
                                            }
                                        }
                                    }
                                }
                            }

                            //MARK: - Add technic button
                            NavigationLink {
                                AddTechnicCDView(vm: AddTechnucViewModel(isEditMode: false, technic: nil))
                            } label: {
                                PlusCircleButtonView()
                            }
                            .padding(10)
                            .offset(y: -60)
                        }
                    }
                    .padding(.horizontal)
                }
                .onAppear {
                    vm.fetchTechnic()
                }
            }
        }
    }
}

#Preview {
    ListTehnics()
}
