//
//  CustomTexrFieldStrokeview.swift
//  MotoApp
//
//  Created by Роман Главацкий on 02.03.2025.
//

import SwiftUI

struct CustomTexrFieldStrokeview: View {
    let title: LocalizedStringKey
    @Binding var text: String
    @FocusState var isFocused: Bool
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $text)
                .padding(.leading)
                .frame(height: 55)
                .focused($isFocused)
                .background (
                    isFocused ? .teracot : .white, in:
                        RoundedRectangle(cornerRadius: 14).stroke(lineWidth: 2)
                    
                )
                .font(.system(size: 18))
                .minimumScaleFactor(0.5)
            
            Text(title)
                .font(.system(size: 16)) 
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .padding(.horizontal, 5)
                .background(.grayApp)
                .padding(.leading)
                .offset(y: isFocused || !text.isEmpty ? -27 : 0)
                .onTapGesture {
                    isFocused.toggle()
                }
                
        }
        .animation(.linear(duration: 0.2), value: isFocused)
        
    }
}

#Preview {
    ZStack {
        Color.grayApp
        CustomTexrFieldStrokeview(title: "New car", text: .constant(""))
    }
}
