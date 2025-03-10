//
//  CustomDatePicker.swift
//  MotoApp
//
//  Created by Роман Главацкий on 09.03.2025.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var selectedDate: Date
    @State private var showDatePicker: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                showDatePicker.toggle()
            }) {
                HStack {
                    Text(selectedDate.formatted(date: .abbreviated, time: .omitted))
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: "calendar")
                        .resizable()
                        .foregroundColor(.teracot)
                        .frame(width: 30, height: 30)
                }
                .frame(height: 50)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.white, lineWidth: 1)
                )
            }
            .buttonStyle(.plain)
            
            if showDatePicker {
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.wheel)
                .tint(.teracot)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: showDatePicker)
    }
}

#Preview {
    @State  var showDatePicker:Date = Date()
    CustomDatePicker(selectedDate: $showDatePicker)
}
