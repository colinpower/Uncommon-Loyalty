//
//  Profile.swift
//  Uncommon Loyalty
//
//  Created by Colin Power on 4/4/22.
//

import SwiftUI

struct Profile: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    
    @State var isSendFeedbackActive:Bool = false
    
    
    //Share sheet tutorial
    //https://www.youtube.com/watch?v=WZOvroeUuxI&t=119s
    
    @State private var isShareSheetActive:Bool = false
    
    @State var username: String = ""
    
    @State var width:CGFloat = CGFloat(100)
    
    @Binding var selectedTab:Int
    
    
    var body: some View {
        
        //THE ACTUAL CODE FOR THIS PAGE IS HERE
        NavigationView{
            GeometryReader { geometry in
        
                    //the content on top of the background
                    VStack(alignment: .leading, spacing: 0) {
        
                        //MARK: Header
                        //SheetHeader(title: "Your account", isActive: $isProfileActive)
        
        
                    ScrollView(.vertical, showsIndicators: false) {
    
                        VStack {
    
                            //MARK: Profile Card
                            VStack(alignment: .center, spacing: 8) {
    
                                //Profile pic
                                HStack {
                                    Spacer()
                                    Image(systemName: "person.crop.circle")
                                        .foregroundColor(Color("Dark1"))
                                        .font(.system(size: 80))
                                    Spacer()
                                }.padding(.top)
                                Text("Colin Power")
                                    .font(.system(size: 24))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("Dark1"))
                                Text(verbatim: "colinjpower1@gmail.com")
                                    .font(.system(size: 18))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("Gray1"))
    //                                    Text("(617) 777-2994)")
    //                                        .font(.system(size: 18))
    //                                        .fontWeight(.regular)
    //                                        .foregroundColor(Color("Gray1"))
    
    //                                    Button {
    //                                        //isAddCompanyPreviewActive.toggle()
    //                                    } label: {
    //                                        HStack {
    //                                            Spacer()
    //                                            Text("Edit Profile")
    //                                                .font(.system(size: 18))
    //                                                .fontWeight(.semibold)
    //                                                .foregroundColor(Color("Dark1"))
    //                                                .padding(.vertical)
    //                                            Spacer()
    //                                        }
    //                                        .background(RoundedRectangle(cornerRadius: 32).foregroundColor(Color(red: 244/255, green: 244/255, blue: 244/255)))
    //                                        .padding(.horizontal)
    //                                        .padding(.vertical)
    //                                    }
    //                                    .sheet(isPresented: $isAddCompanyPreviewActive, content: {
    //                                        AddCompanyPreview(isAddCompanyPreviewActive: $isAddCompanyPreviewActive)
    //                                    })
                            }.padding(.bottom)
                            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
                                .padding()
    
    
                            //MARK: Invite friends
                            WidgetSolo(image: "plus.circle.fill", size: 40, firstLine: "Invite friends", secondLine: "Get 500 points", secondLineColor:Color("ThemeBright") , isActive: $isShareSheetActive)
                                .sheet(isPresented: $isShareSheetActive, content: {
                                    
                                    ShareSheet(items: ["Hey, I created a discount code for you!",  UIImage(imageLiteralResourceName: "Athleisure LA")])
                                    
//                                        ShareSheet(items: ["Hey, download the Uncommon app to manage your rewards points! Check out this link"])
                                })
                            
                            NavigationLink {
                                AllOrders(selectedTab: $selectedTab)
                            } label: {
                                Text("All my orders")
                            }

                            NavigationLink {
                                Wallet(selectedTab: $selectedTab)
                            } label: {
                                Text("All my discounts")
                            }
    
    
                            //MARK: HELP US IMPROVE
                            WideWidgetHeader(title: "HELP US IMPROVE")
    
    
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
    
    
    
    
                            //MARK: Settings
                            WideWidgetHeader(title: "SETTINGS")
                            VStack {
    
                                //Item 1: Name
                                WideWidgetItem(image: "person.fill", size: 20, color: Color("Dark1"), title: "Name")
                                    .padding(.bottom).padding(.bottom)
    
                                //Item 2: Email
                                WideWidgetItem(image: "envelope.fill", size: 20, color: Color("Dark1"), title: "Email").padding(.bottom).padding(.bottom)
    
                                //Item 3: Notifications
                                WideWidgetItem(image: "bell.fill", size: 20, color: Color("Dark1"), title: "Notifications").padding(.bottom).padding(.bottom)
    
                                //Item 4: Get help
                                WideWidgetItem(image: "questionmark.circle.fill", size: 20, color: Color("Dark1"), title: "Get help").padding(.bottom)
    
                            }.padding().background(.white).padding(.bottom)
    
                            //MARK: Sign out
                            HStack {
                                Spacer()
                                Button {
                                    viewModel.signOut()
                                } label: {
                                    Text("Sign out")
                                        .font(.system(size: 16))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(.red))
                                        .padding(.vertical)
                                        .padding(.horizontal, 16)
                                }
                                Spacer()
                            }.background(.white).padding(.bottom, 48)
    
                            
    
                        }
                    }
                        
                    MyTabView(selectedTab: $selectedTab)
                    }
            }
            .background(.white)
            .edgesIgnoringSafeArea([.bottom, .horizontal])
            .navigationTitle("Profile").font(.title)
            .onAppear {
                // stuff goes here
            }
        }
    }
    
    
    
}






//struct Profile_Previews: PreviewProvider {
//    static var previews: some View {
//        Profile()
//    }
//}


//MARK: creating a VC to show the share sheet
struct ShareSheet: UIViewControllerRepresentable {
    //@Binding var isShareSheetActive: Bool
    
    var items : [Any]

    func makeUIViewController(context: Context) -> UIViewController {
        
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        if isShareSheetActive {
//            uiViewController.present(content(), animated: true, completion: nil)
//        }
    }
}


















//
//ScrollView(.vertical, showsIndicators: false) {
//    //My programs section
//    VStack(alignment: .leading) {
//        //Title
//        HStack {
//            Text("My Programs")
//                .font(.system(size: 20))
//                .fontWeight(.semibold)
//                .foregroundColor(Color("Dark1"))
//            Spacer()
//            Button {
//                isAddCompanyPreviewActive.toggle()
//            } label: {
//                Text("Add")
//                    .font(.system(size: 16))
//                    .fontWeight(.semibold)
//                    .foregroundColor(Color("Dark1"))
//                    .padding(.vertical, 6)
//                    .padding(.horizontal, 16)
//                    .background(RoundedRectangle(cornerRadius: 16).foregroundColor(Color(red: 244/255, green: 244/255, blue: 244/255)))
//            }.sheet(isPresented: $isAddCompanyPreviewActive, content: {
//                AddCompanyPreview(isAddCompanyPreviewActive: $isAddCompanyPreviewActive)
//            })
//        }.padding()
//
//        //Body
//        VStack {
//            //FOR EACH LOYALTY PROGRAM, SHOW IT HERE
//            ForEach(viewModel1.myRewardsPrograms) { RewardsProgram in
//
//                NavigationLink(destination: CompanyProfileV2(companyID: RewardsProgram.companyID, companyName: RewardsProgram.companyName, email: RewardsProgram.email, userID: RewardsProgram.userID)) {
//                        RewardsProgramWidget(companyName: RewardsProgram.companyName, image: RewardsProgram.companyName, currentPointsBalance: RewardsProgram.currentPointsBalance, status: RewardsProgram.status)
//                }
//            }
//        }.padding()
//
//        //Footer
//        HStack() {
//            Spacer()
//            Button {
//                isProfileActive.toggle()
//            } label: {
//                Text("See all")
//                    .font(.system(size: 16))
//                    .fontWeight(.semibold)
//                    .foregroundColor(Color.blue)
//            }.sheet(isPresented: $isProfileActive, content: {
//                Profile()
//            })
//            Spacer()
//        }.padding()
//
//    }
//    .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
//    .padding()
//
//    //New content (horizontal scrollview
//    ScrollView (.horizontal, showsIndicators: false) {
//        HStack{
//            RoundedRectangle(cornerRadius: 16)
//                .foregroundColor(Color("Gray3"))
//                .frame(width: geometry.size.width/3*2, height: 120)
//            RoundedRectangle(cornerRadius: 16)
//                .foregroundColor(Color("Gray3"))
//                .frame(width: geometry.size.width/3*2, height: 120)
//            RoundedRectangle(cornerRadius: 16)
//                .foregroundColor(Color("Gray3"))
//                .frame(width: geometry.size.width/3*2, height: 120)
//        }.padding(.horizontal)
//            .padding(.bottom)
//    }
//
//
//    //Help us grow
//    HStack {
//        Text("MAKE US BETTER").kerning(1.2)
//            .font(.system(size: 13))
//            .fontWeight(.medium)
//            .foregroundColor(Color("Gray1"))
//        Spacer()
//    }.padding(.horizontal)
//    VStack{
//        //Suggest new store
//        HStack {
//            Image(systemName: "person.crop.circle")
//                .foregroundColor(.blue)
//                .font(.system(size: 48))
//            VStack(alignment: .leading, spacing: 2) {
//                Text("Suggest a store")
//                    .font(.system(size: 16))
//                    .fontWeight(.semibold)
//                    .foregroundColor(Color("Dark1"))
//                Text("Which stores should we add?")
//                    .font(.system(size: 16))
//                    .fontWeight(.regular)
//                    .foregroundColor(Color("Gray2"))
//            }
//            Spacer()
//            Image(systemName: "chevron.right")
//                .foregroundColor(Color("Gray3"))
//                .font(Font.system(size: 15, weight: .semibold))
//        }.padding(.bottom)
//        //Send feedback
//        HStack {
//            Image(systemName: "person.crop.circle")
//                .foregroundColor(.blue)
//                .font(.system(size: 48))
//            VStack(alignment: .leading, spacing: 2) {
//                Text("Send feedback")
//                    .font(.system(size: 16))
//                    .fontWeight(.semibold)
//                    .foregroundColor(Color("Dark1"))
//                Text("What can we improve?")
//                    .font(.system(size: 16))
//                    .fontWeight(.regular)
//                    .foregroundColor(Color("Gray2"))
//            }
//            Spacer()
//            Image(systemName: "chevron.right")
//                .foregroundColor(Color("Gray3"))
//                .font(Font.system(size: 15, weight: .semibold))
//        }
//
//    }.padding(.horizontal, 12)
//    .padding(.vertical)
//    .background(.white)
//    .padding(.bottom)
//
//}
