//
//  GarageView.swift
//  MotoApp
//
//  Created by Роман on 27.09.2023.
//

import SwiftUI

struct GarageView: View {
    var body: some View {
        VStack {
            Text("Garage")
            Image("door.garage.double.bay.closed")
                .resizable()
                .frame(width: 100, height: 100)
        }
        
        
    }
}

#Preview {
    GarageView()
}
