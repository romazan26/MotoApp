//
//  ProfileViewModel.swift
//  MotoApp
//
//  Created by Роман on 02.11.2023.
//

import Foundation
import RealmSwift
import SwiftUI

final class ProfileViewModel: ObservableObject {
    @Published var currentUser: User!
    @Published var simpleUserName = ""
    @Published var simpleUserSerName = ""


    func addName () {
       
    }
}
