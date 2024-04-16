//
//  tahnicUIViewCell.swift
//  MotoApp
//
//  Created by Роман on 30.11.2023.
//

import SwiftUI

struct technicUIViewCell: View {
    let technic: Technic
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(technic.title) \(technic.note)").font(.largeTitle)
            Divider()
            Text("Колличество работ: \(technic.works.count)").font(.footnote)
            Divider()
        }
        .lineLimit(1)
        .minimumScaleFactor(0.5)
        .bold()
    }
}

#Preview {
    technicUIViewCell(technic: DataManager.shared.createTempDataTechic())
}
