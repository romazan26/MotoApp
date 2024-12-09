//
//  WorksMainView.swift
//  MotoApp
//
//  Created by Роман on 09.12.2024.
//

import SwiftUI

struct WorksMainView: View {
    @StateObject var vm: WorkCDViewmodel
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            
            //MARK: - Image tehcnic
                Image(.works)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)
                    .cornerRadius(20)
            
            //MARK: - Infor table for technic
            VStack {
                HStack{
                    Text(vm.technicCD.title ?? "")
                    Text(vm.technicCD.note ?? "")
                }.font(.system(size: 18, weight: .bold))
                Text(vm.technicCD.type ?? "")
                HStack{
                    CellInfoMainWorksView(text: "odometrLabel", value: "\(vm.getFinalOdometry())", image: "speedometer")
                    CellInfoMainWorksView(text: "spentLabel", value: "\(vm.getFinalPrice())", image: "dollarsign.bank.building")
                    CellInfoMainWorksView(text: "countOfWorks", value: "\(vm.getCountWorks())", image: "gear")
                }
            }
            .padding(8)
            .background {
                Color(colorScheme == .dark ? .white : .black)
                    .opacity(0.05)
                    .cornerRadius(20)
            }
            
            //MARK: - Preview works list
            VStack{
                HStack{
                    Text("labelWorksList")
                    Spacer()
                    NavigationLink {
                        TehnicWorksView(vm: vm)
                    } label: {
                        Text("seeAllButton")
                    }
                    .padding(.horizontal)
                }
                ScrollView(.horizontal) {
                    HStack{
                        ForEach(vm.sortedWorks.prefix(3)) { work in
                            MiniWorkCellView(work: work)
                        }
                        NavigationLink {
                            TehnicWorksView(vm: vm)
                        } label: {
                            Text("...")
                                .minimumScaleFactor(0.5)
                                .fontWeight(.bold)
                                .frame(width: 100, height: 60)
                                .padding(8)
                                .background {
                                    Color(colorScheme == .dark ? .white : .black)
                                        .opacity(0.05)
                                        .cornerRadius(20)
                                }
                        }
                    }
                }
            }
            .padding(8)
            .background {
                Color(colorScheme == .dark ? .white : .black)
                    .opacity(0.05)
                    .cornerRadius(20)
            }
            
            Spacer()
            
            //MARK: - Delete and Edit buttons
            HStack{
                Button {
                    vm.deleteTechnic()
                } label: {
                    GradientButtonView(label: "deleteLabel", color: .red)
                }
                
                GradientButtonView(label: "editButtonLabel", color: .black)

            }
            
            
        }.padding()
    }
}

//#Preview {
//    WorksMainView()
//}
