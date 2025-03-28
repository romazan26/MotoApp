//
//  TechnicInfiView.swift
//  MotoApp
//
//  Created by Роман on 27.11.2024.
//

import SwiftUI

struct TechnicInfoView: View {

    @StateObject var vm: WorkMainViewmodel
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
                
                //MARK: - Count works
                HStack {
                    Text("countOfWorks")
                    Text(": \(vm.getCountWorks())")
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
