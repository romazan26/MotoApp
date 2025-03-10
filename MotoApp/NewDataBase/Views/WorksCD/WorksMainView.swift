//
//  WorksMainView.swift
//  MotoApp
//
//  Created by Роман on 09.12.2024.
//

import SwiftUI

struct WorksMainView: View {
    @StateObject var vm: WorkCDViewmodel
    @StateObject var vmTechnic: CoreDataViewModel
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
                    .padding(.trailing, 10)

                    //MARK: - Image technic
                    if !vm.isEditorWork{
                        if let imageData = vm.convertDataToImage(vm.technicCD.photo){
                            Image(uiImage: imageData)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }else{
                            Image(.newLogo)
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                    }else{
                        Image(.newLogo)
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    
                    //MARK: - Name Technic
                    VStack(alignment: .leading){
                        
                        Text(vm.technicCD.title ?? "")
                            .foregroundStyle(.white)
                            .font(.system(size: 28, weight: .bold, design: .serif))
                            .minimumScaleFactor(0.5)
                        Text(vm.technicCD.note ?? "")
                            .foregroundStyle(.white)
                            .minimumScaleFactor(0.5)
                        
                        Text(vm.technicCD.type ?? "")
                            .foregroundStyle(.white)
                            .minimumScaleFactor(0.5)
                    }
                    Spacer()
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
                                .frame(width: 30, height: 50)
                            Text("sortButtonLabel")
                                .foregroundStyle(.white)
                                .font(.system(size: 10))
                                .minimumScaleFactor(0.5)
                        }
                    }

                    
                }
                .padding()
                .background {
                    LinearGradient(gradient: Gradient(colors: [animate ? Color.grayApp : Color.black.opacity(0.2), animate ? Color.black.opacity(0.1) : Color.grayApp]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(.all)
                        .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animate)
                }
                .onAppear {
                    self.animate = true
                }
                
                .shadow(color: .black, radius: 15)
                VStack{
                    
                    
                    
                    //MARK: - Infor table for technic
                    VStack {
                        HStack{
                            CellInfoMainWorksView(text: "odometrLabel", value: "\(vm.getFinalOdometry())", image: "speedometer")
                            CellInfoMainWorksView(text: "spentLabel", value: "\(vm.getFinalPrice())", image: "dollarsign.bank.building")
                            CellInfoMainWorksView(text: "countOfWorks", value: "\(vm.getCountWorks())", image: "gear")
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
                        
                    }
                    ScrollView {
                        ForEach(vm.sortedWorks) { work in
                            Button {
                                vm.isPresentInfoWork = true
                                vm.simpleWork = work
                            } label: {
                                WorkCellCDView(work: work)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    //MARK: - Delete and Edit buttons
                    HStack{
                        //Delete
                        Button {
                            vmTechnic.isPresentDeleteAlert = true
                        } label: {
                            GradientButtonView(label: "deleteLabel", color: .red)
                        }
                        
                        //Plus
                        NavigationLink {
                            AddWorckForTechnicView(vm: vm)
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
                            AddTechnicCDView(vm: vmTechnic)
                                .onAppear {
                                    vmTechnic.tapOfEdit(technic: vm.technicCD)
                                }
                        } label: {
                            GradientButtonView(label: "editButtonLabel", color: .black)
                        }
                        
                        
                        
                    }
                }.padding()
                
            }
            .navigationDestination(isPresented: $vm.isPresentEditWork, destination: {
                AddWorckForTechnicView(vm: vm)
                    .onAppear {
                        vm.getEditWork()
                    }
            })
            .sheet(isPresented: $vm.isPresentInfoWork, content: {
                WorkFullInfoView(work: vm.simpleWork!, vm: vm)
                    .presentationDetents([.fraction(0.6)])
            })
            .navigationBarBackButtonHidden(true)
            .alert(isPresented: $vmTechnic.isPresentDeleteAlert) {
                Alert(title: Text("deleteTechnicMessage"), primaryButton: .destructive(Text("deleteLabel")) {
                    vm.deleteTechnic()
                    dismiss()
                }, secondaryButton: .cancel())
            }
            
        }
    }
}

#Preview {
    WorksMainView(vm: WorkCDViewmodel(technicCD: TechnicCD(context: CoreDataManager.instance.context)), vmTechnic: CoreDataViewModel())
}
