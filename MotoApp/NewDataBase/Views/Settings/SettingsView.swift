//
//  SettingsView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 07.05.2025.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @State private var animate = false
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        ZStack {
            Color.grayApp.ignoresSafeArea()
            VStack {
                //MARK: - Top tool bar
                CustomTopBarView(barText: "settingsLabel")
                Spacer()
                
                VStack(spacing: 20){
                    //MARK: - Rate us button
                    Button {
                        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            SKStoreReviewController.requestReview(in: scene)
                        }
                    } label: {
                        CellForSettingsView(nameButton: "rateusButton", imageName: "star.fill")
                    }
                    
                    //MARK: - Policy button
                    Button { UIApplication.shared.open(viewModel.policyURL)}
                    label: {
                        CellForSettingsView(nameButton: "policyButton", imageName: "lock.document.fill")
                    }

                    //MARK: - Delete all data button
                    Button {
                        viewModel.isPresentedDeleteAlert.toggle()
                    } label: {
                        CellForSettingsView(nameButton: "resetAllButton", imageName: "arrow.circlepath", red: true)
                    }
                    
                }.padding()
                
                Spacer()
            }
            .alert(isPresented: $viewModel.isPresentedDeleteAlert) {
                Alert(title: Text("resetAllButton"), message: Text("resetDataLabel"), primaryButton: .cancel(), secondaryButton: .destructive(Text("deleteLabel"), action: {
                    viewModel.clearData()
                }))
            }
        }
    }
}

#Preview {
    SettingsView()
}
