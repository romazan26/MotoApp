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
                    HStack {
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
                    .background { TopbarBackGroundView(animate: $animate) }
                    .onAppear { self.animate = true }
                    .shadow(color: .black, radius: 15)

                    //MARK: - Контейнер с ScrollView
                    GeometryReader { geo in
                        ZStack(alignment: .bottomTrailing) {
                            ScrollView {
                                if vm.technics.isEmpty {
                                    Text(LocalizedStringKey("emptyListLabel"))
                                        .multilineTextAlignment(.center)
                                        .frame(height: geo.size.height) // Центрировать если пусто
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
