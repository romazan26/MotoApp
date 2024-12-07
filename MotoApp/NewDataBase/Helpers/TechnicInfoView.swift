//
//  TechnicInfiView.swift
//  MotoApp
//
//  Created by Роман on 27.11.2024.
//

import SwiftUI

struct TechnicInfoView: View {
   // @StateObject var vm: CoreDataViewModel
    @StateObject var vm: WorkCDViewmodel
    //@ObservedObject var technic: TechnicCD
    var body: some View {
        HStack {
            Image(.works)
                .resizable()
                .frame(width: 160, height: 120)
            VStack(alignment: .leading) {
                //MARK: - Title technic
                Text("\(vm.technicCD.title ?? "") \(vm.technicCD.note ?? "")")
                
                //MARK: -Type technic
                Text("\(vm.technicCD.type ?? "")")
                
                //MARK: - Odometr technic
                HStack{
                    Text("odometrLabel")
                    Text(": \(vm.getFinalOdometry())")
                    Spacer()
                }
                 
                //MARK: - Count works
                HStack {
                    Text("countOfWorks")
                    Text(": \(vm.getCountWorks())")
                }
                
                //MARK: - Spent
                HStack{
                    Text("spentLabel")
                    Text(": \(vm.getFinalPrice())")
                }
            }
        Spacer()
        }
        .minimumScaleFactor(0.5)
    }
}

//#Preview {
//    TechnicInfiView()
//}
