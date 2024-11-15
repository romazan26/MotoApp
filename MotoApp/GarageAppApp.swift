//
//  MotoAppApp.swift
//  MotoApp
//
//  Created by Роман on 27.09.2023.
//

import SwiftUI

@main
struct GarageAppApp: App {
    
    @AppStorage("isLogin") var isLogin: Bool = false
    @AppStorage("coreDataActive") var coreDataActive: Bool?
    @ObservedObject var viewModel = CoreDataViewModel()

    var body: some Scene {
        WindowGroup {
            if coreDataActive ?? false{
                ListCoreData(vm: viewModel)
                    .onAppear {
                        print("CoreDataActive: \(coreDataActive)")
                    }
                    
            }else{
                if isLogin {
                    HellowView()
                        .onAppear {
                            print("CoreDataActive: \(coreDataActive)")
                        }
                }else {
                    LoginView()
                        .onAppear {
                            print("CoreDataActive: \(coreDataActive)")
                        }
                }
            }
            
        }
    }
}
