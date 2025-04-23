//
//  extension_UIImage.swift
//  MotoApp
//
//  Created by Роман Главацкий on 22.04.2025.
//
import UIKit

extension UIImage {
    static func from(data: Data?, placeholder: UIImage = UIImage(resource: .newLogo)) -> UIImage {
        guard let data = data, let image = UIImage(data: data) else {
            return placeholder
        }
        return image
    }
}
