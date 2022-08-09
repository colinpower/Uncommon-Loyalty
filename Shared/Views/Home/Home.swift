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
    
    @Namespace var namespace1
    @Namespace var namespace2
    
    @ObservedObject var viewModel1 = RewardsProgramViewModel()
    
    @State var isAddCompanyPreviewActive:Bool = false
    @State var isProfileActive:Bool = false
    @State var isSendFeedbackActive:Bool = false
    @State var isFeaturedWidget1Active:Bool = false
    @State var isFeaturedWidget2Active:Bool = false
    
    
    //TEMP VAR
    @State var isShowingDetailView = false
    @State private var selection: String? = nil
    
    
    
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
                                }
                                
                                //Body
                                VStack {
                                    
                                    ForEach(viewModel1.myRewardsPrograms) { RewardsProgram in
                                        
                                        NavigationLink(destination: CompanyProfileV2(companyID: RewardsProgram.companyID, companyName: RewardsProgram.companyName, email: RewardsProgram.email, userID: RewardsProgram.userID)) {
                                            
                                                RewardsProgramWidget(image: RewardsProgram.companyName, company: RewardsProgram.companyName, status: RewardsProgram.status, currentPointsBalance: RewardsProgram.currentPointsBalance)
                                        
                                        }
                                    }
                                }

                            }.padding().padding(.top)
                                .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white)).padding(.horizontal).padding(.top)

                        
                            //MARK: Discover company (beautiful animation)
                            //https://www.youtube.com/watch?v=f0wYIYfPBa4
                            FeaturedWidget1(namespace: namespace1, isFeaturedWidget1Active: $isFeaturedWidget1Active, category: "Discover", title: "Athleisure's Design Inspiration", subtitle: "After 24 years, how does Athleisure keep reinventing their brand and their iconic look?", backgroundImage: "YellowAthleisure", foregroundImage: "FeaturedAthleisure")
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                        isFeaturedWidget1Active.toggle()
                                    }
                                }
                            
                            //MARK: Quick actions
                            VStack(alignment: .leading, spacing: 0) {
                                
                                //Title
                                HStack {
                                    Text("Quick actions")
                                        .font(.system(size: 20))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("Dark1"))
                                    Spacer()
                                }
                                
                                Text("Earn points for reviewing recent purchases or referring favorite items to your friends.")
                                    .font(.system(size: 16))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("Gray1"))
                                    .multilineTextAlignment(.leading)
                                    .lineSpacing(8)
                                    .padding(.vertical, 16)
                                
                                //Body
                                VStack(alignment: .leading) {
                                    MyQuickActionsItem(companyImage: "Athleisure LA", company: "Athleisure LA", item: "JOGGERS", action: "Review")
                                    MyQuickActionsItem(companyImage: "LululemonGold", company: "Lululemon", item: "Sweatshirt", action: "Refer")
                                }.padding(.top)
                            }.padding().background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white)).padding(.horizontal)
                            
                            
                            //MARK: Discover company (beautiful animation)
                            //https://www.youtube.com/watch?v=f0wYIYfPBa4
                            FeaturedWidget2(namespace: namespace2, isFeaturedWidget2Active: $isFeaturedWidget2Active, category: "Discover", title: "Athleisure's Design Inspiration", subtitle: "After 24 years, how does Athleisure keep reinventing their brand and their iconic look?", backgroundImage: "YellowAthleisure", foregroundImage: "FeaturedAthleisure")
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                        isFeaturedWidget2Active.toggle()
                                    }
                                }
                            
                            
                            //MARK: HELP US IMPROVE
                            WideWidgetHeader(title: "HELP US IMPROVE")
                            VStack {
                                
                                NavigationLink(destination: SuggestAShopPreview(isShowingDetailView: $isShowingDetailView).navigationBarTitle("", displayMode: .inline).navigationBarHidden(true), isActive: $isShowingDetailView) {
                                    WideWidgetItem(image: "lightbulb.circle.fill", size: 40, title: "Suggestions", subtitle: "What should we work on next?")
                                }

                                
//                                Button("Tap to show detail") {
//                                    self.isShowingDetailView = true
//                                }
                                
//                                NavigationLink(destination: SuggestAShopPreview()) {
//
//                                    WideWidgetItem(image: "lightbulb.circle.fill", size: 40, title: "Suggestions", subtitle: "What should we work on next?")
//
//                                }.padding(.bottom)
                                
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
                    
                    if isFeaturedWidget1Active {
                        FeaturedView1(namespace: namespace1, isFeaturedWidget1Active: $isFeaturedWidget1Active, category: "Discover", title: "Athleisure's Design Inspiration", subtitle: "After 24 years, how does Athleisure keep reinventing their brand and their iconic look?", backgroundImage: "YellowAthleisure", foregroundImage: "FeaturedAthleisure", height: geometry.size.height)
                    }
                    
                    if isFeaturedWidget2Active {
                        FeaturedView2(namespace: namespace2, isFeaturedWidget2Active: $isFeaturedWidget2Active, category: "Discover", title: "Athleisure's Design Inspiration", subtitle: "After 24 years, how does Athleisure keep reinventing their brand and their iconic look?", backgroundImage: "YellowAthleisure", foregroundImage: "FeaturedAthleisure", height: geometry.size.height)
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
