//
//  AllWorksView.swift
//  MotoApp
//
//  Created by Роман Главацкий on 22.03.2025.
//

import SwiftUI

struct AllWorksView: View {
    @StateObject var vm: AllWorksViewModel
    @Environment(\.dismiss) var dismiss
    @FocusState private var isFocused: Bool
    @State private var animate = false
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            Color.grayApp.ignoresSafeArea()
            VStack {
                //MARK: - Top tool bar
                HStack{
                    //MARK: - Back button
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 30, height: 80)
                            .shadow(radius: 5)
                            .padding(10)
                    }
                    .padding(.trailing, 10)
                    
                    //MARK: - Image technic
                    Image(uiImage: UIImage.from(data: vm.technicCD.photo))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    //MARK: - Name Technic
                    VStack(alignment: .leading) {
                        
                        Text(vm.technicCD.title ?? "")
                            .foregroundStyle(.white)
                            .font(.system(size: 28, weight: .bold, design: .serif))
                            .minimumScaleFactor(0.5)
                        
                        Spacer()
                        HStack {
                            Text(vm.technicCD.note ?? "")
                                .foregroundStyle(.white)
                                .minimumScaleFactor(0.5)
                            Text(vm.technicCD.type ?? "")
                                .foregroundStyle(.white)
                                .minimumScaleFactor(0.5)
                            
                        }
                    }
                    .padding(.horizontal, 10)
                    
                    Spacer()
                    //MARK: Sorting button
                    Menu {
                        VStack {
                            ForEach(SortOptionWork.allCases , id: \.self) { sort in
                                Button {
                                    vm.selectedSortOption = sort
                                } label: {
                                    Text(sort.rawValue)
                                }
                            }
                        }
                    } label: {
                        VStack{
                            Image(systemName: "list.bullet.clipboard")
                                .resizable()
                                .foregroundStyle(.white)
                                .frame(width: 25, height: 35)
                            Text("sortButtonLabel")
                                .foregroundStyle(.white)
                                .font(.system(size: 10))
                                .minimumScaleFactor(0.5)
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .frame(maxHeight: 100)
                .padding()
                .background {
                    TopbarBackGroundView()
                }
                .onAppear {
                    self.animate = true
                }
                .shadow(color: .black, radius: 15)
                VStack{
                    //MARK: - Search bar
                    CustomSearchBarView(title: "seachLabel", text: $vm.searchText)
                        .focused($isFocused)
                    
                    //MARK: - Preview works list
                    if vm.searchResult.isEmpty {
                        
                        Text("noSearchWorks")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                    }
                    ScrollView {
                        ForEach(vm.searchResult) { work in
                            Button {
                                vm.isPresentInfoWork = true
                                vm.simpleWork = work
                            } label: {
                                WorkCellCDView(work: work)
                            }
                        }
                    }
                }.padding()
            }
            .onAppear {
                vm.appearAllWork()
            }
            .onTapGesture {
                isFocused = false
            }
            //Plus
            NavigationLink {
                AddWorckForTechnicView(vm: AddWorkViewModel(technicCD: vm.technicCD, isEditeWork: false, simpleWork: nil))
            } label: {
                ZStack {
                    Circle()
                        .foregroundStyle(.teracot)
                        .overlay(
                            Circle()
                                .stroke(Color.black.opacity(0.3), lineWidth: 5)
                                .blur(radius: 5)
                                .mask(Circle())
                        )
                    Image(.works)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }.frame(width: 100, height: 100)
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .gesture(
            DragGesture()
                .onEnded { gesture in
                    if gesture.translation.width > 50 { // Свайп вправо
                        dismiss()
                    }
                }
        )
        .navigationDestination(isPresented: $vm.isPresentEditWork, destination: {
            AddWorckForTechnicView(vm: AddWorkViewModel(technicCD: vm.technicCD, isEditeWork: true, simpleWork: vm.simpleWork))
            
        })
        .sheet(isPresented: $vm.isPresentInfoWork, content: {
            WorkFullInfoView(work: vm.simpleWork!, vm: vm)
                .presentationDetents([.fraction(0.6)])
        })
    }
}

#Preview {
    AllWorksView(vm: AllWorksViewModel(technicCD: TechnicCD(context: CoreDataManager.instance.context)))
}
