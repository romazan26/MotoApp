//
//  NewLoadingView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 24.02.2025.
//

import SwiftUI

struct NewLoadingView: View {
    @StateObject var vm = LoadingViewModel()
    var body: some View {
        ZStack {
            Color.grayApp.ignoresSafeArea()
            VStack {
                Spacer()
                Image(.newLogo)
                    .resizable()
                    .frame(width: 250, height: 250)
                Spacer()
                CastonProgressBarView(progress: vm.timeLoading)
            }
            .padding()
            .animation(.easeInOut, value: vm.timeLoading)
            
        }
        .onAppear(perform: {
            vm.startTimer()
        })
        .fullScreenCover(isPresented: $vm.isPresent) {
            ListTehnics()
        }
    }
}

#Preview {
    NewLoadingView()
}
