//
//  ShareSheet.swift
//  MotoApp
//
//  Created by Роман Главацкий on 17.03.2025.
//
import Foundation
import SwiftUI
import UIKit

struct ShareSheet: UIViewControllerRepresentable{
    var items: URL
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let av = UIActivityViewController(activityItems: [items], applicationActivities: nil)
        return av
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
