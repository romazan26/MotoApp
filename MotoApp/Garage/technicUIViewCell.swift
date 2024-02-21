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
            Text("Тип: \(technic.type)")
            Text("Название: \(technic.title)")
            Text("Примечание: \(technic.note)")
            Divider()
        }
        .font(.title3)
    }
}

#Preview {
    technicUIViewCell(technic: Technic())
}
