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
    
    class Coordinator: PHPickerViewControllerDelegate {
        
        
        private let perent: PhotoPicker
        
        init(_ perent: PhotoPicker) {
            self.perent = perent
        }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            for image in results {
                if image.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    image.itemProvider.loadObject(ofClass: UIImage.self) { newImage, error in
                        if let error = error {
                            print(error.localizedDescription)
                        }else {
                            self.perent.pickerResult = (newImage as! UIImage)
                        }
                    }
                } else {
                    print("Selected asset is not image")
                }
            }
            perent.isPresented = false
        }
    }
}
