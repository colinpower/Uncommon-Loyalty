//
//  Home.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 1/17/22.
//

import SwiftUI
import FirebaseAuth


//how to merge and store two firestore queries
//https://stackoverflow.com/questions/65688706/how-to-merge-two-queries-using-firestore-swift


struct Home: View {
    
    //@State var showingDiscountScreen: Bool = false
    @ObservedObject var viewModel1 = RewardsProgramViewModel()
    
    @State var isAddCompanyPreviewActive:Bool = false
    @State var isProfileActive:Bool = false
    @State var isSendFeedbackActive:Bool = false
    @State var showingAnimation:Bool = false
    
    
    @State var x : [CGFloat] = [0, 0, 0, 0, 0, 0]
    @State var colorbg : [Color] = [Color.red, Color.orange, Color.yellow, Color.green, Color.blue, Color.purple]
    @State var endOfCards = false
    
    //@Binding var selectedTab: Int
    
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                
                ZStack(alignment: .top) {
                    
                    //MARK: Background color
                    Color("Background")
                    
                    //the content on top of the background
                    VStack(alignment: .leading) {
                        
                        //MARK: Header
                        HStack{
                            Text("Home")
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Dark1"))
                            Spacer()
                            Button {
                                isProfileActive.toggle()
                            } label: {
                                Image(systemName: "person.crop.circle")
                                    .foregroundColor(Color("Dark1"))
                                    .font(.system(size: 30))
                            }.fullScreenCover(isPresented: $isProfileActive, content: {
                                Profile(isProfileActive: $isProfileActive)
                            })
                        }.padding(.top, 60).padding(.horizontal)
                        
                        //this is the start of the scrollview with all the content
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            //MARK: Loyalty Programs
                            VStack(alignment: .leading) {
                                
                                //Title
                                HStack {
                                    Text("Loyalty Programs")
                                        .font(.system(size: 20))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("Dark1"))
                                    Spacer()
                                    Button {
                                        isAddCompanyPreviewActive.toggle()

                                    } label: {
                                        Text("Add")
                                            .font(.system(size: 16))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("Dark1"))
                                            .padding(.vertical, 6)
                                            .padding(.horizontal, 12)
                                            .background(RoundedRectangle(cornerRadius: 19).foregroundColor(Color("Background")))
                                    }.fullScreenCover(isPresented: $isAddCompanyPreviewActive, content: {
                                        AddCompanyPreview(isAddCompanyPreviewActive: $isAddCompanyPreviewActive)
                                    })
                                }.padding(.horizontal)
                                
                                
                                //Body
                                VStack {
                                    
                                    ForEach(viewModel1.myRewardsPrograms) { RewardsProgram in
                                        
                                        NavigationLink(destination: CompanyProfileV2(companyID: RewardsProgram.companyID, companyName: RewardsProgram.companyName, email: RewardsProgram.email, userID: RewardsProgram.userID)) {
                                            
                                                RewardsProgramWidget(image: RewardsProgram.companyName, company: RewardsProgram.companyName, status: RewardsProgram.status, currentPointsBalance: RewardsProgram.currentPointsBalance)
                                        
                                        }
                                    }
                                }.padding(.horizontal)

                                //Footer
                                HStack() {
                                    Spacer()
                                    Button {
                                        isAddCompanyPreviewActive.toggle()
                                    } label: {
                                        Text("See all")
                                            .font(.system(size: 18))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("ThemeBright"))
                                    }.fullScreenCover(isPresented: $isAddCompanyPreviewActive, content: {
                                        AddCompanyPreview(isAddCompanyPreviewActive: $isAddCompanyPreviewActive)
                                    })
                                    Spacer()
                                }.padding(.vertical).padding(.vertical, 4)
                            }.padding(.top).padding(.vertical)
                            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white)).padding()

                            //MARK: Quick prompt content
                            ScrollView (.horizontal, showsIndicators: false) {
                                HStack{
                                    RoundedRectangle(cornerRadius: 16)
                                        .foregroundColor(Color("Gray3"))
                                        .frame(width: geometry.size.width/3*2, height: 120)
                                    RoundedRectangle(cornerRadius: 16)
                                        .foregroundColor(Color("Gray3"))
                                        .frame(width: geometry.size.width/3*2, height: 120)
                                    RoundedRectangle(cornerRadius: 16)
                                        .foregroundColor(Color("Gray3"))
                                        .frame(width: geometry.size.width/3*2, height: 120)
                                }.padding(.horizontal)
                                    .padding(.bottom)
                            }
                        
                            //MARK: Discover company
                            //Turn this into a beautiful animation
                            //https://www.youtube.com/watch?v=f0wYIYfPBa4
                            VStack(alignment: .leading) {
                                
                                //Title
                                HStack {
                                    Text("Discover Athleisure LA")
                                        .font(.system(size: 20))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("Dark1"))
                                    Spacer()
                                    Button {
                                        isAddCompanyPreviewActive.toggle()

                                    } label: {
                                        Text("Add")
                                            .font(.system(size: 16))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("Dark1"))
                                            .padding(.vertical, 6)
                                            .padding(.horizontal, 12)
                                            .background(RoundedRectangle(cornerRadius: 19).foregroundColor(Color("Background")))
                                    }.fullScreenCover(isPresented: $isAddCompanyPreviewActive, content: {
                                        AddCompanyPreview(isAddCompanyPreviewActive: $isAddCompanyPreviewActive)
                                    })
                                }.padding(.horizontal)
                                
                                
                                //Body
                                VStack {
                                    
                                    ForEach(viewModel1.myRewardsPrograms) { RewardsProgram in
                                        
                                        NavigationLink(destination: CompanyProfileV2(companyID: RewardsProgram.companyID, companyName: RewardsProgram.companyName, email: RewardsProgram.email, userID: RewardsProgram.userID)) {
                                            
                                                RewardsProgramWidget(image: RewardsProgram.companyName, company: RewardsProgram.companyName, status: RewardsProgram.status, currentPointsBalance: RewardsProgram.currentPointsBalance)
                                        
                                        }
                                    }
                                }.padding(.horizontal)

                                //Footer
                                HStack() {
                                    Spacer()
                                    Button {
                                        isAddCompanyPreviewActive.toggle()
                                    } label: {
                                        Text("See all")
                                            .font(.system(size: 18))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("ThemeBright"))
                                    }.fullScreenCover(isPresented: $isAddCompanyPreviewActive, content: {
                                        AddCompanyPreview(isAddCompanyPreviewActive: $isAddCompanyPreviewActive)
                                    })
                                    Spacer()
                                }.padding(.vertical).padding(.vertical, 4)
                            }.padding(.top).padding(.vertical)
                                .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white)).padding(.horizontal)
                            
                            //MARK: HELP US IMPROVE
                            WideWidgetHeader(title: "HELP US IMPROVE")
                            VStack {
                                NavigationLink(destination: SuggestAShopPreview()) {
                                    
                                    WideWidgetItem(image: "lightbulb.circle.fill", size: 40, title: "Suggestions", subtitle: "What should we work on next?")
                                    
                                }.padding(.bottom)
                                
                                //Send feedback
                                Button {
                                    isSendFeedbackActive.toggle()
                                } label: {
                                    WideWidgetItem(image: "bubble.left.circle.fill", size: 40, title: "Send feedback", subtitle: "We respond super fast!")
                                }.fullScreenCover(isPresented: $isSendFeedbackActive) {
                                    SendFeedback(isSendFeedbackActive: $isSendFeedbackActive)
                                }

                            }.padding(.horizontal, 12).padding(.vertical).background(.white)
                        }
                    }
                }
            }
            .ignoresSafeArea()
            .navigationTitle("")
            .navigationBarHidden(true)
            .onAppear {
                self.viewModel1.listenForMyRewardsPrograms(email: Auth.auth().currentUser?.email ?? "")
                print("CURRENT USER IS")
                print(Auth.auth().currentUser?.email ?? "")
                print(self.viewModel1.myRewardsPrograms)
            }
            .onDisappear {
                print("DISAPPEAR")
                if self.viewModel1.listener1 != nil {
                    print("REMOVING LISTENER")
                    self.viewModel1.listener1.remove()
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}





//MARK: Unused code

//This was for showing a quick link to the rewards page
//                    NavigationLink(destination: ReviewProductPreview(companyID: "zKL7SQ0jRP8351a0NnHM", email: "colinjpower1@gmail.com", orderID: "", userID: "mhjEZCv9JGdk0NUZaHMcNrDsH1x2")) {
//                        Image(systemName: "plus.circle.fill")
//                            .font(.system(size: 30))
//                        }



//This was for swiping cards at the top
//ScrollView(.horizontal) {
//if x.count == 0 || endOfCards {
//    EmptyView()
//} else {
//    ZStack {
//        ForEach(0..<x.count, id: \.self) { i in
//            ReviewOrReferWidget(colorbg: colorbg[i])
//                .frame(width: geometry.size.width, height: geometry.size.height * 0.2, alignment: .center)
//                .offset(x: self.x[i])
//                .gesture(DragGesture()
//                    .onChanged({ value in
//                        if value.translation.width > 0 {
//                            self.x[i] = value.translation.width
//                        } else {
//                            self.x[i] = value.translation.width
//                        }
//
//
//                    })
//                    .onEnded({ value in
//                        if value.translation.width > 0 {
//                            if value.translation.width > 100 {
//                                self.x[i] = geometry.size.width
//                                if i == 0 {
//                                    withAnimation {
//                                        endOfCards = true
//                                    }
//
//                                }
//                            } else {
//                                self.x[i] = 0
//                            }
//                        } else {
//                            if value.translation.width < -100 {
//                                self.x[i] = -geometry.size.width
//                                if i == 0 {
//                                    withAnimation {
//                                        endOfCards = true
//                                    }
//                                }
//                            } else {
//                                self.x[i] = 0
//                            }
//                        }
//                    }))
//        }
//    }
//}
