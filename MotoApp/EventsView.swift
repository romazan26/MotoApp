//
//  EventsView.swift
//  MotoApp
//
//  Created by Роман on 27.09.2023.
//

import SwiftUI

struct EventsView: View {
    var body: some View {
        VStack {
            Text("Events")
            Image(systemName: "exclamationmark.bubble.fill")
                .resizable()
                .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    EventsView()
}
