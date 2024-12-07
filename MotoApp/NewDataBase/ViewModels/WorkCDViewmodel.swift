//
//  TechnicCDViewmodel.swift
//  MotoApp
//
//  Created by Роман on 04.12.2024.
//
import Foundation

final class WorkCDViewmodel: ObservableObject{
    let technicCD: TechnicCD
    
    init(technicCD: TechnicCD) {
        self.technicCD = technicCD
    }
    
}
