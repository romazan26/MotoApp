//
//  CellForTypeWorkView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 01.07.2025.
//

import SwiftUI

struct CellForTypeWorkView: View {
    let type: TypeWork
    let action: () -> Void
    var body: some View {
        HStack {
            Text(type.nameType ?? "")
                .foregroundStyle(.black)
                .font(.system(size: 16, weight: .bold))
            Spacer()
            Button(action: action) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(.red)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 1)
        }
    }
}

#Preview {
    ZStack {
        Color.grayApp
        CellForTypeWorkView(type: TypeWork.init(context: CoreDataManager.instance.context), action: {})
    }
}
