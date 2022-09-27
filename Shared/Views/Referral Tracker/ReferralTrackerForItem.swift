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
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                
                //MARK: CONTENT
                ScrollView(.vertical) {
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        //divider
                        Divider()
                            .padding(.bottom)
                            .padding(.leading)
                        
                        //MARK: CURRENT REVIEWS & REFERRALS
                        VStack(alignment: .center, spacing: 0) {
                            HStack(alignment: .center, spacing: 0) {
                                
                                
                                NavigationLink {
                                    //destination
                                } label: {
                                    //label
                                    
                                    let amt = referralsViewModel.snapshotOfReferralsForItem.filter { $0.status == "SENT" }
                                    
                                    ReferralTrackerWidget(title: "Sent", amount: String(amt.count), subtitle: "", isSelected: false)
                                        .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 116)
                                        .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: CGFloat(11)))
                                }
                                
                                Spacer()
                                
                                NavigationLink {
                                    //                                ReferralTracker()
                                } label: {
                                    //label
                                    ReferralTrackerWidget(title: "In Progress", amount: "3", subtitle: "", isSelected: false)
                                        .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 116)
                                        .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: CGFloat(11)))
                                }
                                
                                Spacer()
                                
                                NavigationLink {
                                    //                                ReferralTracker()
                                } label: {
                                    //label
                                    ReferralTrackerWidget(title: "Complete", amount: "9", subtitle: "7 Expired", isSelected: false)
                                        .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 116)
                                        .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: CGFloat(11)))
                                }
                                
                                
                                
                            }.padding()
                                .frame(width: UIScreen.main.bounds.width, height: 150, alignment: .center)
                        }
                        
                        
                        //MARK: REFERRAL HISTORY
                        VStack(alignment: .leading, spacing: 0) {
                            
                            //divider
                            Divider()
                                .padding(.vertical)
                            
                            Text("Here's all of your referrals")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.black)
                                .frame(width: UIScreen.main.bounds.width / 2, alignment: .leading)
                                .padding(.leading, 2)
                                .padding(.vertical)

                        }.padding(.leading)
                            .padding(.bottom)
                        
                        
                        ReferralTrackingCard(recipient: "Catherine", discountAmount: "$20", discountExpiration: "Jan 1", rewardPointsForReferrer: "20,000", stateOfReferral: "SENT")
                            .clipShape(RoundedRectangle(cornerRadius: 11))
                            .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: 5, y: 4))
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                        
                        
                        ReferralTrackingCard(recipient: "Catherine", discountAmount: "$20", discountExpiration: "Jan 1", rewardPointsForReferrer: "20,000", stateOfReferral: "USED")
                            .clipShape(RoundedRectangle(cornerRadius: 11))
                            .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: 5, y: 4))
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                        
                        
                        
                        
                        ReferralTrackingCard(recipient: "Catherine", discountAmount: "$20", discountExpiration: "Jan 1", rewardPointsForReferrer: "20,000", stateOfReferral: "COMPLETE")
                            .clipShape(RoundedRectangle(cornerRadius: 11))
                            .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: 5, y: 4))
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                        
                        
                        ReferralTrackingCard(recipient: "Catherine", discountAmount: "$20", discountExpiration: "Jan 1", rewardPointsForReferrer: "20,000", stateOfReferral: "EXPIRED")
                            .clipShape(RoundedRectangle(cornerRadius: 11))
                            .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: 5, y: 4))
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            
                        
                        
                    }
                }
                
            }
            .background(Color("Background"))
            .edgesIgnoringSafeArea([.horizontal, .bottom])
            .navigationTitle("Referral Tracker").foregroundColor(Color("Background"))
            .onAppear {
                
                self.referralsViewModel.getSnapshotOfReferralsForItem(userID: userID, itemID: itemID)
                
            }
        }
        

    }
}
