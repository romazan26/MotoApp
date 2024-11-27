//
//  TechnicInfiView.swift
//  MotoApp
//
//  Created by Роман on 27.11.2024.
//

import SwiftUI

struct TechnicInfoView: View {
    @StateObject var vm: CoreDataViewModel
    @ObservedObject var technic: TechnicCD
    var body: some View {
        HStack {
            Image(.works)
                .resizable()
                .frame(width: 160, height: 120)
            VStack(alignment: .leading) {
                //MARK: - Title technic
                Text("\(technic.title ?? "") \(technic.note ?? "")")
                
                //MARK: -Type technic
                Text("\(technic.type ?? "")")
                
                //MARK: - Odometr technic
                HStack{
                    Text("odometrLabel")
                    Text(": \(vm.getFinalOdometry(technic: technic))")
                    Spacer()
                }
                 
                //MARK: - Count works
                HStack {
                    Text("countOfWorks")
                    Text(": \(vm.getCountWorks(technic: technic))")
                }
                
                //MARK: - Spent
                HStack{
                    Text("spentLabel")
                    Text(": \(vm.getFinalPrice(technic: technic))")
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
