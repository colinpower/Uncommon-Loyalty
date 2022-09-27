//
//  ReferralTrackerForItem.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/26/22.
//

import SwiftUI

struct ReferralTrackerForItem: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @ObservedObject var referralsViewModel = ReferralsViewModel()
    
    var userID:String
    var itemID:String
    var itemTitle:String
    
    @State var filterReferralsForItemBy:String = ""
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            //MARK: CONTENT
            ScrollView(.vertical) {
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    
                    //MARK: CURRENT REVIEWS & REFERRALS
                    VStack(alignment: .center, spacing: 0) {
                        HStack(alignment: .center, spacing: 0) {
                            
                            
                            let amtSENT = referralsViewModel.snapshotOfReferralsForItem.filter { $0.status == "SENT" }.count
                            let amtUSED = referralsViewModel.snapshotOfReferralsForItem.filter { $0.status == "USED" }.count
                            let amtCOMPLETE = referralsViewModel.snapshotOfReferralsForItem.filter { $0.status == "COMPLETE" }.count
                            let amtEXPIRED = referralsViewModel.snapshotOfReferralsForItem.filter { $0.status == "EXPIRED" }.count
                            
                            Button {
                                
                                filterReferralsForItemBy = filterReferralsForItemBy == "SENT" ? "" : "SENT"
                                
                            } label: {
                                
                                ReferralTrackerWidget(title: "Sent", amount: String(amtSENT), subtitle: String(amtEXPIRED) + " Expired", isSelected: false)
                                    .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 116)
                                    .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: CGFloat(11)))
                            }
                            
                            Spacer()
                            
                            Button {
                                
                                filterReferralsForItemBy = filterReferralsForItemBy == "USED" ? "" : "USED"
                                
                            } label: {
                                
                                ReferralTrackerWidget(title: "In Progress", amount: String(amtUSED), subtitle: "", isSelected: false)
                                    .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 116)
                                    .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: CGFloat(11)))
                                
                            }
                            
                            Spacer()
                            
                            Button {
                                filterReferralsForItemBy = filterReferralsForItemBy == "COMPLETE" ? "" : "COMPLETE"
                                
                            } label: {
                             
                                ReferralTrackerWidget(title: "Complete", amount: String(amtCOMPLETE), subtitle: "", isSelected: false)
                                    .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 116)
                                    .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: CGFloat(11)))
                            }
                            
                        }.padding()
                            .frame(width: UIScreen.main.bounds.width, height: 150, alignment: .center)
                    }
                        .padding(.top)
                    
                    
                    //MARK: REFERRAL HISTORY
                    VStack(alignment: .leading, spacing: 0) {
                        
                        //divider
                        Divider()
                            .padding(.vertical)
                        Group {
                            if filterReferralsForItemBy == "SENT" {
                                Text("You sent these referrals, but they haven't been used yet.")
                            } else if filterReferralsForItemBy == "USED" {
                                Text("Your friends have used these discounts.")
                            } else if filterReferralsForItemBy == "COMPLETE" {
                                Text("You earned rewards for these referrals")
                            } else {
                                Text("These are all the referrals you created")
                            }
                        }
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: UIScreen.main.bounds.width * 3 / 4, alignment: .bottomLeading)
                        .padding(.leading, 2)
                        .padding(.vertical)

                    }.padding(.leading)
                        .padding(.bottom)
                    
                    
                    if filterReferralsForItemBy.isEmpty {
                        
                        ForEach(referralsViewModel.snapshotOfReferralsForItem) { referral in
                            
                            NavigationLink {
                                ReferralDetailView(referral: referral)
                            } label: {
                                
                                ReferralTrackingCard(recipient: referral.userSendingReferralEmail, discountAmount: "$" + String(referral.referralDiscountAmount), discountExpiration: "Jan 1", rewardPointsForReferrer: String(referral.referralBonusPoints), stateOfReferral: referral.status)
                                    .clipShape(RoundedRectangle(cornerRadius: 11))
                                    .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: 5, y: 4))
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            
                            
                            
                        }
                        
                    } else if filterReferralsForItemBy == "SENT" {
                        
                        ForEach(referralsViewModel.snapshotOfReferralsForItem.filter { ($0.status == filterReferralsForItemBy) || ($0.status == "EXPIRED") }) { referral in
                            
                            NavigationLink {
                                ReferralDetailView(referral: referral)
                            } label: {
                                ReferralTrackingCard(recipient: referral.userSendingReferralEmail, discountAmount: "$" + String(referral.referralDiscountAmount), discountExpiration: "Jan 1", rewardPointsForReferrer: String(referral.referralBonusPoints), stateOfReferral: referral.status)
                                    .clipShape(RoundedRectangle(cornerRadius: 11))
                                    .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: 5, y: 4))
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            
                        }
                        
                    } else {
                        
                        ForEach(referralsViewModel.snapshotOfReferralsForItem.filter { $0.status == filterReferralsForItemBy }) { referral in
                            NavigationLink {
                                ReferralDetailView(referral: referral)
                            } label: {
                                ReferralTrackingCard(recipient: referral.userSendingReferralEmail, discountAmount: "$" + String(referral.referralDiscountAmount), discountExpiration: "Jan 1", rewardPointsForReferrer: String(referral.referralBonusPoints), stateOfReferral: referral.status)
                                    .clipShape(RoundedRectangle(cornerRadius: 11))
                                    .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: 5, y: 4))
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            
                        }
                        
                    }
                }
            }
            
        }
        .background(Color("Background"))
        .edgesIgnoringSafeArea([.horizontal, .bottom])
        .navigationTitle(itemTitle)
        .navigationBarTitleDisplayMode(.inline)
        .foregroundColor(Color("Background"))
        
        .onAppear {
            
            self.referralsViewModel.getSnapshotOfReferralsForItem(userID: userID, itemID: itemID)
            
        }
    }
}


