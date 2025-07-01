//
//  AllTypeWorkView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 01.07.2025.
//

import SwiftUI

struct AllTypeWorkView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = TypeWorkViewModel()
    
    var body: some View {
        ZStack {
            Color.grayApp.ignoresSafeArea()
            VStack {
                //MARK: - Top tool bar
                CustomTopBarView(barText: "listTypeofWork")
                Spacer()
                VStack{
                    
                    //MARK: - List of type
                    ScrollView {
                        ForEach(vm.typeWorks) { type in
                            CellForTypeWorkView(type: type) {
                                vm.deleteTypework(type: type)
                            }
                        }
                    }
                    HStack{
                        //MARK: - Close button
                        Button {
                            dismiss()
                        } label: {
                            GradientButtonView(label: "closebutton", color: .teracot)
                        }
                        //MARK: - Add button
                        Button {
                            vm.isPresentAddTypeView.toggle()
                        } label: {
                            GradientButtonView(label: "addButton", color: .orangeApp)
                        }
                        
                    }
                }.padding()
            }
            if vm.isPresentAddTypeView {
                AddTypeWorkView(vm: vm)
            }
        }
    }
}

#Preview {
    AllTypeWorkView()
}
