//
//  CheckList.swift
//  MotoApp
//
//  Created by Роман Главацкий on 07.05.2025.
//

import SwiftUI

struct CheckListView: View {
    
    @StateObject private var vm = CheckListViewModel()
    
    var body: some View {
        ZStack {
            Color.grayApp.ignoresSafeArea()
            
            VStack {
                CustomTopBarView(barText: "labelCheckLists")
                GeometryReader { geo in
                    ZStack(alignment: .bottomTrailing) {
                        //MARK: - List of checklist
                        ScrollView{
                            VStack{
                                if vm.checkList.isEmpty {
                                    Text("No checklist")
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.center)
                                        .frame(height: geo.size.height)
                                }else{
                                    ForEach(vm.checkList) { checkList in
                                        
                                        Text(checkList.title ?? "Untitled")
                                    }
                                }
                                
                            }
                            .frame(width: geo.size.width)
                        }
                        
                        //MARK: - Plus button
                        Button {
                            ///ACTOPN plus
                        } label: {
                            PlusCircleButtonView()
                        }
                        .padding(10)
                        
                    }
                }
            }
        }
    }
}

#Preview {
    CheckListView()
}
