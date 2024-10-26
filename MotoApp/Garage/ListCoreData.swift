//
//  ListCoreData.swift
//  MotoApp
//
//  Created by Роман on 26.10.2024.
//

import SwiftUI

struct ListCoreData: View {
    @StateObject var vm: GarageViewModel
    var body: some View {
        VStack {
            ScrollView {
                ForEach(vm.technicsCD) { technic in
                    Text("\(technic.title ?? "")")
                    if let works = technic.works?.allObjects as? [WorkCD] {
                        ForEach(works) { work in
                            Text("\(work.nameWork ?? "")")
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    ListCoreData(vm: GarageViewModel(user: User()))
}
