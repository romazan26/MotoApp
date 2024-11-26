//
//  КуышяуидуЕучеАшудвМшуц.swift
//  MotoApp
//
//  Created by Роман on 26.11.2024.
//

import SwiftUI

struct ResizebleTextFieldView: View {
    @Binding var text: String
    @State private var textHeight: CGFloat = 40 // Начальная высота
    @State var extraHeight: CGFloat
     
    var body: some View {
        TextEditor(text: $text)
            .frame(height: max(textHeight +  extraHeight, 40)) // Минимальная высота
            .padding()
            .background(Color.back)
            .clipShape(RoundedRectangle(cornerRadius: 10,style: .continuous))
            .shadow(color: .gray, radius: 8, x: 8, y: 8)
            .shadow(color: .back, radius: 8, x: -8, y: -8)
            .onChange(of: text) { _ in
                recalculateHeight()
            }
            .onAppear {
                recalculateHeight()
            }
    }
    
    private func recalculateHeight() {
        // Вычисление высоты на основе текста
        let width = UIScreen.main.bounds.width - 32 // Учитываем отступы
        let font = UIFont.systemFont(ofSize: 17)
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingRect = NSString(string: text).boundingRect(
            with: textSize,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        )
        withAnimation {
            extraHeight = CGFloat(max(0, text.split(separator: "\n").count - 1)) * 10
            textHeight = ceil(boundingRect.height)
        }
    }
}

#Preview {
    ResizebleTextFieldView(text: .constant("ASDA"), extraHeight: 10)
}
