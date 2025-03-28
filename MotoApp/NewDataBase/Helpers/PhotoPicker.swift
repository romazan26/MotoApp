//
//  PhotoPicker.swift
//  Movieplanner
//
//  Created by Роман on 14.06.2024.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = PHPickerViewController
    
    let configuration: PHPickerConfiguration
    
    @Binding var pickerResult: UIImage?
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
  
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    @MainActor  // Помечаем Coordinator как работающий на главном потоке
    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            // Обрабатываем результаты выбора
            processPickerResults(results)
            
            // Закрываем пикер
            parent.isPresented = false
        }
        
        private func processPickerResults(_ results: [PHPickerResult]) {
            for image in results {
                if image.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    image.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] newImage, error in
                        if let error = error {
                            print("Error loading image: \(error.localizedDescription)")
                            return
                        }
                        
                        guard let uiImage = newImage as? UIImage else {
                            print("Failed to cast to UIImage")
                            return
                        }
                        
                        // Обновляем результат на главном потоке
                        DispatchQueue.main.async {
                            self?.parent.pickerResult = uiImage
                        }
                    }
                } else {
                    print("Selected asset is not an image")
                }
            }
        }
    }
}
