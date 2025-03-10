//
//  WorkViewCD.swift
//  MotoApp
//
//  Created by Роман on 25.11.2024.
//

import SwiftUI

struct WorkFullInfoView: View {
    @ObservedObject var work: WorkCD
    @ObservedObject var vm: WorkCDViewmodel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Color.grayApp.ignoresSafeArea()
            VStack {
                Text("\(work.nameWork ?? "")")
                    .font(.system(size: 20, weight: .bold))
                LazyVGrid(columns: [GridItem(.fixed(110), alignment: .leading),
                                    GridItem(.fixed(20)),
                                    GridItem(alignment: .leading)],alignment: .leading) {
                    Text("noteLabel")
                    Text(":")
                    Text("\(Dateformatter(date: work.date ?? Date()))")
                    Text("priceLabel")
                    Text(":")
                    Text("\(work.price)")
                    Text("odometrLabel")
                    Text(":")
                    Text("\(work.odometr)")
                }
                                    .padding()
                                    .background(Color.gray.opacity(0.5))
                                    .clipShape(RoundedRectangle(cornerRadius: 10,style: .continuous))              
                
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
                    Button {
                        vm.isPresentInfoWork.toggle()
                        vm.isPresentEditWork.toggle()
                        
                    } label: {
                        GradientButtonView(label: "editButtonLabel", color: .black)
                    }
                }
                
            }.padding()
        }
    }
    //MARK: - Dateformatter
    private func Dateformatter(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d.M.yyyy"
        return dateFormatter.string(from: date)
    }
}


#Preview {
    WorkFullInfoView(work: WorkCD(context: CoreDataManager.instance.context), vm: WorkCDViewmodel(technicCD: TechnicCD(context: CoreDataManager.instance.context)))
}
