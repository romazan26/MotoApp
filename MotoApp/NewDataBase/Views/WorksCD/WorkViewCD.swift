//
//  WorkViewCD.swift
//  MotoApp
//
//  Created by Роман on 25.11.2024.
//

import SwiftUI

struct WorkViewCD: View {
    @ObservedObject var work: WorkCD
   // @State private var shouldNavigate = false
    @ObservedObject var vm: WorkCDViewmodel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            LazyVGrid(columns: [GridItem(alignment: .leading), GridItem(alignment: .leading)]) {
                Text("titleLabel")
                Text(" : \(work.nameWork ?? "")")
                Text("noteLabel")
                Text(" : \(Dateformatter(date: work.date ?? Date()))")
                Text("priceLabel")
                Text(" : \(work.price)")
                Text("odometrLabel")
                Text(" : \(work.odometr)")
            }
            .padding()
            .background(Color.back)
            .clipShape(RoundedRectangle(cornerRadius: 10,style: .continuous))
            .shadow(color: .gray, radius: 8, x: 8, y: 8)
            .shadow(color: .back, radius: 8, x: -8, y: -8)
            
            Spacer()
            
            HStack {
                //MARK: - Delete button
                Button {
                    vm.deleteWork(work: work)
                    dismiss()
                } label: {
                    GradientButtonView(label: "deleteLabel", color: .red)
                }

                //MARK: - Edit button
                NavigationLink {
                    AddWorckForTechnicView(vm: vm)
                        .onAppear {
                        vm.getEditWork(work: work)
                    }
                } label: {
                    GradientButtonView(label: "editButtonLabel", color: .black)
                }


                
            }
            
            Spacer()
        }.padding()
    }
    //MARK: - Dateformatter
    private func Dateformatter(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d.M.yyyy"
        return dateFormatter.string(from: date)
    }
}


//#Preview {
//    WorkViewCD(work: WorkCD())
//}
