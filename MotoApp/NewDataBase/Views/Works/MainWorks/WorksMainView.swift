//
//  WorksMainView.swift
//  MotoApp
//
//  Created by Роман on 09.12.2024.
//

import SwiftUI

struct WorksMainView: View {
    @StateObject var vm: WorkMainViewmodel
    @Environment(\.dismiss) var dismiss
    
    @State private var animate = false
    
    
    var body: some View {
        
        ZStack {
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
                            .frame(width: 20, height: 80)
                            .shadow(radius: 5)
                    }
                    .frame(width: 20, height: 80)
                    .padding(.trailing, 10)

                    //MARK: - Image technic
                        if let imageData = vm.convertDataToImage(vm.technicCD.photo){
                            Image(uiImage: imageData)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }else{
                            Image(.newLogo)
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                    
                    
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
                            Spacer()
                            
                            //MARK: Share button
                            Button {
                                vm.tapShareButton()
                            } label: {
                                VStack{
                                    Image(systemName: "square.and.arrow.up")
                                        .resizable()
                                        .foregroundStyle(.white)
                                        .frame(width: 25, height: 35)
                                    Text("shareButtonLabel")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 10))
                                        .minimumScaleFactor(0.5)
                                }
                            }

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
                    }
                    .padding(.horizontal, 10)
                   
                    
                }
                .frame(maxWidth: .infinity)
                .frame(maxHeight: 100)
                .padding()
                .background {TopbarBackGroundView(animate: $animate)}
                .onAppear {
                    self.animate = true
                }
                .shadow(color: .black, radius: 15)
                VStack{
                    //MARK: - Infor table for technic
                    VStack {
                        HStack{
                            CellInfoMainWorksView(text: "odometrLabel",
                                                  value: "\(vm.getFinalOdometry())",
                                                  image: "speedometer")
                            CellInfoMainWorksView(text: "spentLabel",
                                                  value: "\(vm.getFinalPrice())",
                                                  image: "dollarsign.bank.building")
                            Button {
                                vm.isPresentAllWorks.toggle()
                            } label: {
                                VStack {
                                    if vm.isFliped {
                                        TextCellInfoMainView(text: "seeAllButton")
                                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                                    } else {
                                        CellInfoMainWorksView(text: "countOfWorks",
                                                              value: "\(vm.getCountWorks())",
                                                              image: "gear")
                                            .transition(.opacity)
                                    }
                                }
                                .foregroundStyle(.black)
                                .rotation3DEffect(.degrees(vm.isFliped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                            }
                            .onAppear {
                                vm.toggleAnimation()
                            }
                            .onDisappear {
                                vm.toggleAnimation()
                            }
                        }
                    }
                    .padding(8)
                    .background {
                        Color(.white)
                            .opacity(0.05)
                            .cornerRadius(20)
                    }
                    
                    //MARK: - Preview works list
                    if vm.sortedWorks.isEmpty {
                        
                        Text("noWorksLabel")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                    }else{
                        ScrollView {
                            ForEach(vm.sortedWorks.prefix(3)) { work in
                                WorkCellCDView(work: work)
                            }
                            Button {
                                vm.isPresentAllWorks.toggle()
                            } label: {
                                HStack {
                                    Text("seeAllWorks")
                                    Text("...")
                                    Spacer()
                                }.foregroundStyle(.teracot)
                                    .font(.system(size: 20, weight: .bold, design: .monospaced))
                                    .minimumScaleFactor(0.5)
                            }
                            
                        }
                    }
                    
                    Spacer()
                    
                    //MARK: - Delete and Edit buttons
                    HStack{
                        //Delete
                        Button {
                            vm.isPresentDeleteAlert = true
                        } label: {
                            GradientButtonView(label: "deleteLabel", color: .red)
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

                        //Edit
                        NavigationLink {
                            AddTechnicCDView(vm: AddTechnucViewModel(isEditMode: true,
                                                                     technic: vm.technicCD))
                        } label: {
                            GradientButtonView(label: "editButtonLabel", color: .black)
                        }
                        
                        
                        
                    }
                }.padding()
                
            }
            
            .sheet(isPresented: $vm.isPresentShareSheet, content: {
                ShareSheet(items: vm.simpleShareText!)
            })
            .navigationDestination(isPresented: $vm.isPresentAllWorks, destination: {
                AllWorksView(vm: AllWorksViewModel(technicCD: vm.technicCD))
            })
            .navigationBarBackButtonHidden(true)
            .gesture(
                            DragGesture()
                                .onEnded { gesture in
                                    if gesture.translation.width > 50 { // Свайп вправо
                                        dismiss()
                                    }
                                }
                        )
            .alert(isPresented: $vm.isPresentDeleteAlert) {
                Alert(title: Text("deleteTechnicMessage"), primaryButton: .destructive(Text("deleteLabel")) {
                    vm.deleteTechnic()
                    dismiss()
                }, secondaryButton: .cancel())
            }
            
        }
        .onAppear {
            vm.updateWork()
            print("appear")
        }
    }
   
}

#Preview {
    WorksMainView(vm: WorkMainViewmodel(technicCD: TechnicCD(context: CoreDataManager.instance.context)))
}
