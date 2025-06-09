//
//  CustomTabBar.swift
//  MotoApp
//
//  Created by Роман Главацкий on 09.06.2025.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectPage: PageView
    var views: [PageView]
    @Namespace private var animation
        
    var body: some View {
        
            
            HStack {
                ForEach(views, id: \.self) { view in
                    Spacer()
                    TabBarButton(tabIcon: view.imageName,
                                 tabTitle: view.title,
                                 isSelected: selectPage == view,
                                 animation: animation,
                                 action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            selectPage = view
                        }
                    })
                    
                    Spacer()
                }
            }
            .frame(height: 60)
            .background(
                Color.white
                    .shadow(radius: 5)
                    .blur(radius: 10, opaque: true)
                    .opacity(0.5)
                    .clipShape(.capsule)
            )
        
    }
}

struct TabItem {
    let icon: String
    let title: String
}

struct TabBarButton: View {
    let tabIcon: String
    let tabTitle: String
    let isSelected: Bool
    let animation: Namespace.ID
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                ZStack {
                    if isSelected {
                        Circle()
                            .fill(Color.teracot)
                            .frame(width: 50, height: 50)
                            .matchedGeometryEffect(id: "background", in: animation)
                            .offset(y: -15)
                    }
                    
                    Image(systemName: tabIcon)
                        .font(.system(size: isSelected ? 24 : 20))
                        .foregroundColor(isSelected ? .white : .gray)
                        .offset(y: isSelected ? -15 : 0)
                }
                
                Text(tabTitle)
                    .font(.system(size: 14, weight: .bold,design: .monospaced))
                    .foregroundColor(isSelected ? .black : .gray)
                    .offset(y: isSelected ? -10 : 0)
            }
        }
    }
}

#Preview {
    MainView()
}

