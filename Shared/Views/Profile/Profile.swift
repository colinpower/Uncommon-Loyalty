//
//  Profile.swift
//  Uncommon Loyalty
//
//  Created by Colin Power on 4/4/22.
//

import SwiftUI

struct Profile: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @ObservedObject var discountCodesViewModel = DiscountCodesViewModel()
    
    
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
                            Text(viewModel.email ?? "Email not loaded yet")
                                .font(.system(size: 18))
                                .fontWeight(.regular)
                                .foregroundColor(Color("Gray1"))

                        }.padding(.bottom)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
                            .padding()

                        //MARK: Invite friends
                        WidgetSolo(image: "plus.circle.fill", size: 40, firstLine: "Invite friends", secondLine: "Get 500 points", secondLineColor:Color("ThemeBright") , isActive: $isShareSheetActive)
                            .sheet(isPresented: $isShareSheetActive, content: {
                                
                                ShareSheet(items: ["Hey, join me on the Uncommon app!"]) //,  UIImage(imageLiteralResourceName: "Athleisure LA")])
                                
    //                                        ShareSheet(items: ["Hey, download the Uncommon app to manage your rewards points! Check out this link"])
                            })


                        //MARK: Settings
                        WideWidgetHeader(title: "MORE")
                        VStack {

                            //Item 1: Orders
                            NavigationLink {
                                //AllOrders(selectedTab: $selectedTab)
                            } label: {
                                WideWidgetItem(image: "bag.fill", size: 20, color: Color("Dark1"), title: "My Orders")
                                    .padding(.bottom).padding(.bottom)
                            }
                            
                            //Item 3: Feedback
                            //Send feedback
                            Button {
                                isSendFeedbackActive.toggle()
                            } label: {
                                WideWidgetItem(image: "bubble.left.fill", size: 20, color: Color("Dark1"), title: "Send feedback").padding(.bottom).padding(.bottom)
                            }.fullScreenCover(isPresented: $isSendFeedbackActive) {
                                SendFeedback(isSendFeedbackActive: $isSendFeedbackActive)
                            }

                            //Item 4: Get help
                            WideWidgetItem(image: "questionmark.circle.fill", size: 20, color: Color("Dark1"), title: "Get help").padding(.bottom)

                        }.padding().background(.white).padding(.bottom)

                        //MARK: Sign out
                        HStack {
                            Spacer()
                            Button {
                                let signOutResult = viewModel.signOut()
                                
                                if !signOutResult {
                                    
                                    //error signing out here.. handle it somehow?
                                    
                                }
                                
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
            .background(Color("Background"))
            .edgesIgnoringSafeArea([.bottom, .horizontal])
            .navigationTitle("Profile").font(.title)
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






struct ProfileReviewStatsWidget: View {
    
    var title:String
    var amount:String
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(alignment: .center, spacing: 4) {

                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color("Dark1"))
                
                Spacer()
                
                Image(systemName: "star.fill")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color("ReviewTeal"))
                    .padding(.bottom, 1)
                
            }
            .padding(.bottom, 10)
            .padding(.top, 16)
            .padding(.horizontal)

            
            HStack(spacing: 0) {
                Spacer()
                Text(amount)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(amount == "0" ? Color("Gray1") : Color("Dark1"))
                    .padding(.bottom, 24)
                    .padding(.bottom, 10)
                Spacer()
            }
        }.frame(height: 116)
    }
}

struct ProfileReferralStatsWidget: View {
    
    var title:String
    var amount:String
    var subtitle:String
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(alignment: .center, spacing: 4) {
                
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color("Dark1"))
                
                Spacer()
                
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color("ReferPurple"))
                    .padding(.bottom, 1)
                
            }
            .padding(.bottom, 10)
            .padding(.top, 16)
            .padding(.horizontal)
            
            
            
            
                
            
            HStack(spacing: 0) {
                Spacer()
                VStack(alignment: .center, spacing: 0) {
                    Text(amount)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(amount == "0" ? Color("Gray1") : Color("Dark1"))
                        .padding(.bottom, 6)
                    
                    Text(subtitle)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(subtitle.prefix(1) == "0" ? Color(.white) : Color("Gray1"))
                        .padding(.bottom, 16)
                }
                Spacer()
            }
        }.frame(height: 116)
    }
}
