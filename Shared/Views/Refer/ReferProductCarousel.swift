//
//  ReferProductCarousel.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/4/22.
//

import SwiftUI

struct ReferProductCarousel: View {
    
    //Environment
    @EnvironmentObject var viewModel: AppViewModel

    //ViewModels
    @ObservedObject var reviewsViewModel = ReviewsViewModel()
    @ObservedObject var rewardsProgramViewModel = RewardsProgramViewModel()

    //State
    @State var indexOfCurrentReferPage:Int = 0
    
    @State var isShowingContactsList:Bool = false
    @State var selectedContact:[String] = ["", "", "", ""]  // ID, first name, last name, phone number
    
    //@State var userSuggestedCode:String = ""
    @State var userAcceptedCode:String = ""
    
    @State var userSelectedColor:Color = .gray
        
    //Binding
    @Binding var isShowingReferExperience:Bool
    
    //Required variables
    var screenWidth:CGFloat = UIScreen.main.bounds.width     //this should be 428 for an iPhone 12 Pro Max
    var totalHeaderHeight:CGFloat = CGFloat(104) + CGFloat(UIScreen.main.bounds.width / 1.6)
    var item: Items
    
    var arrayOfReferralPrompts: [String] = ["Who's it for?", "Add a discount code", "Select a color", "Ta-da! Send it"]   //eventually will just pull from the viewmodel for this
    
    
    
    @State var imageString = "AthleisureLA-Gold-Discount"
    
    
    
    var body: some View {
        
        //MARK: The VStack containing the entire REFER flow
        VStack(alignment: .leading, spacing: 0) {
            
            //MARK: HEADER (84 height)
            VStack(alignment: .center, spacing: 0) {
                
                //The top bar
                HStack(alignment: .center) {
                    
                    Label {
                        Text("Step \(indexOfCurrentReferPage+1)")
                            .font(.system(size: 23, weight: .semibold))
                            .foregroundColor(Color("Dark1"))
                    } icon: {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(Color("ReferPurple"))
                    }
                    
                    Spacer()
                    
                    Button {
                        isShowingReferExperience.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color("Dark1"))
                            .frame(width: 24, height: 24)
                    }
                    
                }.padding(.horizontal)
                .padding(.top, 60)
                .padding(.bottom, 20)
                .frame(maxWidth: screenWidth, maxHeight: 104)


            }
            .frame(width: screenWidth, height: 104)
            
            
            //MARK: CARD (SCREENWIDTH / 1.6 is height)
            customReferralCard(screenWidth: screenWidth)

            
            //MARK: CONTENT & HORIZONTAL SCROLLVIEW
            Color.clear.overlay(
                HStack(spacing: 0) {
                    
                    ReferProductStep1(indexOfCurrentReferPage: $indexOfCurrentReferPage, isShowingContactsList: $isShowingContactsList, selectedContact: $selectedContact, item: item, promptForStep1: arrayOfReferralPrompts[0], screenWidth: screenWidth, totalHeaderHeight: totalHeaderHeight)
                    
                    ReferProductStep2(userAcceptedCode: $userAcceptedCode, indexOfCurrentReferPage: $indexOfCurrentReferPage, item: item, promptForStep2: arrayOfReferralPrompts[1], screenWidth: screenWidth, totalHeaderHeight: totalHeaderHeight)
                    
                    ReferProductStep3(userSelectedColor: $userSelectedColor, indexOfCurrentReferPage: $indexOfCurrentReferPage, item: item, promptForStep3: arrayOfReferralPrompts[2], screenWidth: screenWidth, totalHeaderHeight: totalHeaderHeight)
                    
                    ReferProductStep4(userSelectedColor: $userSelectedColor, selectedContact: $selectedContact, indexOfCurrentReferPage: $indexOfCurrentReferPage, userAcceptedCode: $userAcceptedCode, isShowingReferExperience: $isShowingReferExperience, item: item, promptForStep4: arrayOfReferralPrompts[3], screenWidth: screenWidth, totalHeaderHeight: totalHeaderHeight, imageString: $imageString)
                    
                } , alignment: .leading)
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height - totalHeaderHeight)
            .offset(x: -1 * CGFloat(indexOfCurrentReferPage) * screenWidth)
            
        }
        .ignoresSafeArea()
        .background(Color("Background"))
        .onAppear {
            self.rewardsProgramViewModel.listenForOneRewardsProgram(email: "colinjpower1@gmail.com", companyID: "zKL7SQ0jRP8351a0NnHM")
        }
    }
}





struct customReferralCard: View {
    
    var screenWidth:CGFloat
    
    var body: some View {
        
        
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            GeometryReader { geometry in

                Image("AthleisureLA-Gold-Discount")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width, height: geometry.size.width / 1.6, alignment: .center)
                    .clipped()
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 3)

            }
            .frame(maxWidth: screenWidth, maxHeight: UIScreen.main.bounds.width / 1.6)
            .padding(.horizontal)
            Spacer()
        }.frame(width: screenWidth, height: UIScreen.main.bounds.width / 1.6)
           
    }
}
