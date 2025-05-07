//
//  PageIconView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 05.05.2025.
//

import SwiftUI

struct PageIconView: View {
    let page: PageView
        let selectedPage: PageView
    let width, height: CGFloat

        var body: some View {
            VStack {
                Image(systemName: page.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width, height: height)
                    .padding(.top, 10)
                    .scaleEffect(selectedPage == page ? 1.2 : 0.9)
                Text(page.title)
                    .font(.footnote)
                Spacer()
            }
            .animation(.easeInOut, value: selectedPage)
            .padding(.horizontal, -4)
            .foregroundColor(selectedPage == page ? .teracot : .white)
        }

        var iconName: String {
            switch page {
            case .checklist: return "checklist"
            case .garage: return "car.fill"
            case .settings: return "gearshape.fill"
            }
        }
}

