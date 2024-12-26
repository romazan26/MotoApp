//
//  LoadingViewModel.swift
//  MotoApp
//
//  Created by Роман on 02.12.2024.
//

import SwiftUI

final class LoadingViewModel: ObservableObject {
    
    @Published var timeLoading: Int = 0
    @Published var isPresent: Bool = false
    
    
    func starttimer(){
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
            if self.timeLoading < 100{
                self.timeLoading += 1
            }else {
                timer.invalidate()
                self.isPresent = true
            }
        }
    }
}
