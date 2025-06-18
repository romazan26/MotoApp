//
//  CustomTabBar.swift
//  MotoApp
//
//  Created by Роман Главацкий on 09.06.2025.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectPage: PageView
    @Binding var isVisible: Bool
    var views: [PageView]
    @Namespace private var animation
    @State private var hideTimer: Timer?
        
    var body: some View {
        
        ZStack{
            HStack {
                ForEach(views, id: \.self) { view in
                    Spacer()
                    TabBarButton(isVisible: isVisible
                                ,tabIcon: view.imageName,
                                 tabTitle: view.title,
                                 isSelected: selectPage == view,
                                 animation: animation,
                                 action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            selectPage = view
                            startTimer()
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
                    .opacity(0.6)
                    .clipShape(.capsule)
                    .padding(.horizontal)
            )
            .offset(x: isVisible ? 0 : -UIScreen.main.bounds.width)
        // Выбранная иконка, которая всегда видна
        if !isVisible {
            TabBarButton(isVisible: false,
                         tabIcon: selectPage.imageName,
                         tabTitle: selectPage.title,
                         isSelected: true,
                         animation: animation) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isVisible = true
                }
            }
            .frame(width: 60, height: 60)
            .offset(y: 30)
            .offset(x: -UIScreen.main.bounds.width/2 + 40)
        }
    }
        .onAppear {
            startTimer()
        }
    }
    func startTimer() {
        // Сбрасываем предыдущий таймер
        hideTimer?.invalidate()
        
        // Показываем таббар
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            isVisible = true
        }
        
        // Запускаем новый таймер
        hideTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isVisible = false
            }
        }
    }
}

struct TabItem {
    let icon: String
    let title: String
}

struct TabBarButton: View {
    let isVisible: Bool
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
                if isVisible {
                    Text(tabTitle)
                        .font(.system(size: 14, weight: .bold,design: .monospaced))
                        .foregroundColor(isSelected ? .black : .gray)
                        .offset(y: isSelected ? -10 : 0)
                }
            }
        }
    }
}

#Preview {
    MainView()
}

