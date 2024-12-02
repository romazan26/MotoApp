//
//  LoadingView.swift
//  MotoApp
//
//  Created by Роман on 02.12.2024.
//

import SwiftUI

struct LoadingView: View {
    @StateObject var vm = LoadingViewModel()
    var body: some View {
        ZStack {
            Image(.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            ProgressView()
                .padding(.top, 80)
        }
        .onAppear(perform: {
            vm.starttimer()
        })
        .fullScreenCover(isPresented: $vm.isPresent) {
            ListCoreData()
        }
    }
}

#Preview {
    LoadingView()
}
