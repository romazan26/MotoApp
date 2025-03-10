//
//  LoadingViewModel.swift
//  MotoApp
//
//  Created by Роман on 02.12.2024.
//

import SwiftUI
import Combine

final class LoadingViewModel: ObservableObject {
    @Published var timeLoading: Double = 0
    @Published var isPresent: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func startTimer() {
        Timer.publish(every: 0.03, on: .main, in: .common)
            .autoconnect()
            .scan(0.0) { (accumulatedTime, _) in
                min(accumulatedTime + 0.01, 0.88)
            }
            .handleEvents(receiveOutput: { [weak self] value in
                if value >= 0.88 {
                    self?.isPresent = true
                    self?.cancellables.removeAll()
                }
                
            })
            .assign(to: &$timeLoading)
    }
}
