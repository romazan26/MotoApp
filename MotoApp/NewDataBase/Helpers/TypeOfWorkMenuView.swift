//
//  TypeOfWorkMenuView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 02.07.2025.
//

import SwiftUI

struct TypeOfWorkMenuView: View {
    
    var typeWork: [TypeWork] = []
    var selectedTypeWork: TypeWork?
    var actionAll: () -> Void = {}
    var actionType: (_ type: TypeWork) -> Void = {type in }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack{
                Button {
                    actionAll()
                } label: {
                    Text("All")
                        .padding(8)
                        .foregroundStyle(.black)
                        .background {
                            Color(selectedTypeWork == nil ? .teracot : .white)
                                .cornerRadius(15)
                        }
                }
                
                ForEach(typeWork) { type in
                    Button {
                        actionType(type)
                    } label: {
                        Text(type.nameType ?? "")
                            .padding(8)
                            .foregroundStyle(.black)
                            .background {
                                Color(selectedTypeWork == type ? .teracot : .white)
                                    .cornerRadius(15)
                            }
                    }

                    
                }
            }
        }
    }
}

#Preview {
    TypeOfWorkMenuView()
}
