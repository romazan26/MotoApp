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
    
    var body: some View {
        
        ZStack {
            Color.grayApp.ignoresSafeArea()
            VStack {
                //MARK: - Top tool bar
                CustomTopBarView(barImage: UIImage.from(data: vm.technicCD.photo),
                                 titleUp: vm.technicCD.title ?? "",
                                 titleDown: vm.technicCD.note ?? "")
                VStack{
                    //MARK: - Infor table for technic
                    VStack {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                            CellInfoMainWorksView(text: "odometrLabel",
                                                  value: "\(vm.getFinalOdometry())",
                                                  image: "speedometer")
                            .frame(height: 150)
                            CellInfoMainWorksView(text: "spentLabel",
                                                  value: "\(vm.getFinalPrice())",
                                                  image: "dollarsign.bank.building")
                            .frame(height: 150)
                            
                            //MARK: - All works button
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
                            .frame(height: 150)
                            .onAppear {
                                vm.toggleAnimation()
                            }
                            .onDisappear {
                                vm.toggleAnimation()
                            }
                            
                            //MARK: - Share button
                            Button {
                                vm.tapShareButton()
                            } label: {
                                CellInfoMainWorksView(text: "shareButtonLabel", value: "", image: "square.and.arrow.up")
                                    .frame(height: 150)
                                    .foregroundStyle(.black)
                            }
                        }
                        )
                    }
                    .padding(8)
                    .background {
                        Color(.white)
                            .opacity(0.05)
                            .cornerRadius(20)
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
