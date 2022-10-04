//
//  ReferralTracker.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/22/22.
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

struct ReferralTracker: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @ObservedObject var referralsViewModel = ReferralsViewModel()
    
    @Binding var selectedTab:Int
    
    @State var filterReferralsBy:String = ""
    
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
                                
                                Button {
                                    
                                    filterReferralsBy = filterReferralsBy == "CREATED" ? "" : "CREATED"

                                    
                                } label: {
                                    if filterReferralsBy == "CREATED" {
                                        
                                        let numberSent = referralsViewModel.snapshotOfAllReferrals.filter { $0.status.status == "CREATED" }.count
                                        let numberExpired = referralsViewModel.snapshotOfAllReferrals.filter { $0.status.status == "EXPIRED" }.count
                                        
                                        ReferralTrackerWidget(title: "Sent", amount: String(numberSent), subtitle: String(numberExpired) + " Expired", isSelected: true)
                                            .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 116)
                                            .background(RoundedRectangle(cornerRadius: 11).shadow(radius: CGFloat(11)))
                                    } else {
                                        
                                        let numberSent = referralsViewModel.snapshotOfAllReferrals.filter { $0.status.status == "CREATED" }.count
                                        let numberExpired = referralsViewModel.snapshotOfAllReferrals.filter { $0.status.status == "EXPIRED" }.count
                                        
                                        ReferralTrackerWidget(title: "Sent", amount: String(numberSent), subtitle: String(numberExpired) + " Expired", isSelected: false)
                                            .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 116)
                                            .background(RoundedRectangle(cornerRadius: 11).shadow(radius: CGFloat(11)))
                                    }
                                }
                                
                                Spacer()
                                
                                Button {
                                    
                                    filterReferralsBy = filterReferralsBy == "USED" ? "" : "USED"
                                    
                                } label: {
                                    
                                    if filterReferralsBy == "USED" {
                                        
                                        let numberUsed = referralsViewModel.snapshotOfAllReferrals.filter { $0.status.status == "USED" }.count
                                        
                                        ReferralTrackerWidget(title: "In Progress", amount: String(numberUsed), subtitle: "", isSelected: true)
                                            .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 116)
                                            .background(RoundedRectangle(cornerRadius: 11).shadow(radius: CGFloat(11)))
                                    } else {
                                        
                                        let numberUsed = referralsViewModel.snapshotOfAllReferrals.filter { $0.status.status == "USED" }.count
                                        
                                        ReferralTrackerWidget(title: "In Progress", amount: String(numberUsed), subtitle: "", isSelected: false)
                                            .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 116)
                                            .background(RoundedRectangle(cornerRadius: 11).shadow(radius: CGFloat(11)))
                                    }
                                }
                                
                                Spacer()
                                
                                Button {
                                    
                                    filterReferralsBy = filterReferralsBy == "COMPLETE" ? "" : "COMPLETE"
                                    
                                } label: {
                                    
                                    if filterReferralsBy == "COMPLETE" {
                                        
                                        let numberComplete = referralsViewModel.snapshotOfAllReferrals.filter { $0.status.status == "COMPLETE" }.count
                                        
                                        ReferralTrackerWidget(title: "Complete", amount: String(numberComplete), subtitle: "XXX" + " Pts Earned", isSelected: true)
                                            .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 116)
                                            .background(RoundedRectangle(cornerRadius: 11).shadow(radius: CGFloat(11)))
                                    } else {
                                        
                                        let numberComplete = referralsViewModel.snapshotOfAllReferrals.filter { $0.status.status == "COMPLETE" }.count
                                        let numberExpired = referralsViewModel.snapshotOfAllReferrals.filter { $0.status.status == "EXPIRED" }.count
                                        
                                        ReferralTrackerWidget(title: "Complete", amount: String(numberComplete), subtitle: "XXX" + " Pts Earned", isSelected: false)
                                            .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 116)
                                            .background(RoundedRectangle(cornerRadius: 11).shadow(radius: CGFloat(11)))
                                    }
                                }
                                
                            }.padding()
                                .frame(width: UIScreen.main.bounds.width, height: 150, alignment: .center)
                        }
                        
                        
                        //MARK: REFERRAL HISTORY
                        VStack(alignment: .leading, spacing: 0) {
                            
                            //divider
                            Divider()
                                .padding(.vertical)
                            
                            VStack(alignment: .leading, spacing:0) {
                                if filterReferralsBy == "CREATED" {
                                    Text("You sent these referrals")
                                } else if filterReferralsBy == "USED" {
                                    Text("These referrals have been used")
                                } else if filterReferralsBy == "COMPLETE" {
                                    Text("These referrals are complete")
                                } else {
                                    Text("Here's all of your referrals")
                                }
                                
                            }
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: UIScreen.main.bounds.width / 2, alignment: .leading)
                            .padding(.leading, 2)
                            .padding(.vertical)

                        }.padding(.leading)
                            .padding(.bottom)
                        
                        
                        if filterReferralsBy.isEmpty {
                            
                            ForEach(referralsViewModel.snapshotOfAllReferrals) { referral in
                                
                                NavigationLink {
                                    ReferralDetailView(referral: referral)
                                } label: {
                                    
                                    ReferralTrackingCard(referralObject: referral, recipient: referral.recipient.firstName, discountAmount: "$" + String(referral.offer.rewardAmount), discountCode: referral.card.discountCode, discountExpiration: String(referral.offer.expirationTimestamp), rewardPointsForReferrer: String(referral.reward.rewardAmount), stateOfReferral: referral.status.status)
                                        .clipShape(RoundedRectangle(cornerRadius: 11))
                                        .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: 5, y: 4))
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)
                                    
                                }
                                
                                
                                
                            }
                            
                        } else if filterReferralsBy == "COMPLETE" {
                            
                            ForEach(referralsViewModel.snapshotOfAllReferrals.filter { ($0.status.status == filterReferralsBy) || ($0.status.status == "EXPIRED") }) { referral in
                                
                                NavigationLink {
                                    ReferralDetailView(referral: referral)
                                } label: {
                                    ReferralTrackingCard(referralObject: referral, recipient: referral.recipient.firstName, discountAmount: "$" + String(referral.offer.rewardAmount), discountCode: referral.card.discountCode, discountExpiration: String(referral.offer.expirationTimestamp), rewardPointsForReferrer: String(referral.reward.rewardAmount), stateOfReferral: referral.status.status)
                                        .clipShape(RoundedRectangle(cornerRadius: 11))
                                        .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: 5, y: 4))
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)
                                }
                            }
                            
                        } else {
                            
                            ForEach(referralsViewModel.snapshotOfAllReferrals.filter { $0.status.status == filterReferralsBy }) { referral in
                                
                                NavigationLink {
                                    ReferralDetailView(referral: referral)
                                } label: {
                                    ReferralTrackingCard(referralObject: referral, recipient: referral.recipient.firstName, discountAmount: "$" + String(referral.offer.rewardAmount), discountCode: referral.card.discountCode, discountExpiration: String(referral.offer.expirationTimestamp), rewardPointsForReferrer: String(referral.reward.rewardAmount), stateOfReferral: referral.status.status)
                                        .clipShape(RoundedRectangle(cornerRadius: 11))
                                        .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: 5, y: 4))
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)
                                }
                            }
                            
                        }
                                                
                    }
                }
                
                //MARK: TABS
                MyTabView(selectedTab: $selectedTab)
                
            }
            .background(Color("Background"))
            .edgesIgnoringSafeArea([.horizontal, .bottom])
            .navigationTitle("Referral Tracker").foregroundColor(Color("Background"))
            .onAppear {
                
                self.referralsViewModel.getSnapshotOfAllReferrals(userID: viewModel.userID ?? "")

            }
        }
        

    }
}

struct ReferralTrackingCard: View {
    
    var referralObject: Referrals
    
    var recipient: String
    var discountAmount: String
    var discountCode: String
    var discountExpiration: String
    var rewardPointsForReferrer: String
    var stateOfReferral: String
    
    
    @State var backgroundURL = ""
    
    
    var contentOfCard:[String] {
        
        switch stateOfReferral {
            
        case "CREATED":
            return [
                discountAmount + " sent to " + recipient,
                "Expires in " + discountExpiration + " days"
            ]
        case "USED":
            return [
                recipient + " used your referral credit",
                "You'll earn " + rewardPointsForReferrer + " points if this purchase isn't returned."
            ]
            
        case "COMPLETE":
            return [
                "Referral complete!",
                "You referred " + recipient + " and earned " + rewardPointsForReferrer + " points. Congrats to you!"
            ]
            
        case "EXPIRED":
            return [
                "Expired on " + discountExpiration,
                recipient + " did not use your referral credit."
            ]
        
        default:
            return ["No title", "No subtitle"]
        }
    }
    
    var body: some View {

        
        VStack(alignment: .center, spacing: 0) {
            
            //MARK: Top section of card (height: 80)
            HStack(alignment: .top, spacing: 0) {
                
                if backgroundURL != "" {
                    WebImage(url: URL(string: backgroundURL)!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                        .padding(.vertical, 16)
                        .padding(.horizontal)
                } else {
                    Image("redshorts")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                        .padding(.vertical, 16)
                        .padding(.horizontal)
                }
                
                
                
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    Text(contentOfCard[0])
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(Color("Dark1"))
                        .padding(.bottom, 8)
                    
                    Text("Created discount code " + discountCode)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color("Gray2"))

                }.padding(.vertical, 16)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color("Gray2"))
                    .padding(.top, 16)
                    .padding(.trailing, 12)
                
            }.frame(minHeight: 80)
            
            Divider().padding(.vertical, 1)
            
            //MARK: Bottom section of card (height: 26 + 24 padding up and down)
//            VStack(alignment: .center, spacing: 0) {
//                //progress bar
//                ZStack(alignment: .leading) {
//
//                    Capsule().foregroundColor(Color("Gray3"))
//                        .frame(width: UIScreen.main.bounds.width - 60, height: 6)
//
//                    if stateOfReferral == "SENT" {
//                        Capsule().foregroundColor(Color("ReviewComplementaryGreen"))
//                            .frame(width: 60, height: 6)
//                    } else if stateOfReferral == "USED" {
//                        Capsule().foregroundColor(Color("ReviewComplementaryGreen"))
//                            .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 6)
//                    } else if stateOfReferral == "COMPLETE" {
//                        Capsule().foregroundColor(Color("ReviewComplementaryGreen"))
//                            .frame(width: UIScreen.main.bounds.width - 60, height: 6)
//                    } else if stateOfReferral == "EXPIRED" {
//                        Capsule().foregroundColor(Color.red)
//                            .frame(width: UIScreen.main.bounds.width - 60, height: 6)
//                    }
//
//                }.frame(width: UIScreen.main.bounds.width - 60, height: 6)
//                    .padding(.bottom, 8)
//
//                HStack(alignment: .center, spacing: 0) {
//                    Text("Sent")
//                        .font(.system(size: 12, weight: .semibold, design: .rounded))
//                        .foregroundColor(Color("Dark1"))
//
//                    Spacer()
//
//                    Text("Used")
//                        .font(.system(size: 12, weight: .regular, design: .rounded))
//                        .foregroundColor(Color("Gray2"))
//
//                    Spacer()
//
//                    Text("Complete")
//                        .font(.system(size: 12, weight: .regular, design: .rounded))
//                        .foregroundColor(Color("Gray2"))
//
//                }
//                .frame(width: UIScreen.main.bounds.width - 60, height: 12)
//
//            }.frame(width: UIScreen.main.bounds.width - 60, height: 26)
            ReferralTrackingCardProgressBar(status: stateOfReferral)
                //.padding(.vertical, 12)
            
        }
        .onAppear {
            
            let backgroundPath = "companies/" + referralObject.ids.companyID + "/items/" + String(referralObject.ids.shopifyProductID) + ".png"
            
            let storage = Storage.storage().reference()
            
            storage.child(backgroundPath).downloadURL { url, err in
                if err != nil {
                    print(err?.localizedDescription ?? "Issue showing the right image")
                    return
                } else {
                    self.backgroundURL = "\(url!)"
                }
            }
        }
        
        
        
        //.frame(height: 154)
        
    }
}

struct ReferralTrackingCardProgressBar: View {
    
    var status:String
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            GeometryReader { geometry in
                
                if status == "CREATED" {
                    
                    VStack(alignment: .center, spacing: 0) {
                        //progress bar
                        ZStack(alignment: .leading) {
                            
                            Capsule().foregroundColor(Color("Gray3"))
                                .frame(width: geometry.size.width, height: 6)
                            
                            Capsule().foregroundColor(Color("ReviewComplementaryGreen"))
                                .frame(width: 60, height: 6)
                            
                        }
                        .frame(width: geometry.size.width, height: 6)
                        .padding(.bottom, 8)
                        
                        
                        HStack(alignment: .center, spacing: 0) {
                            
                            Text("Sent")
                                .font(.system(size: 12, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("Dark1"))
                                .frame(width: geometry.size.width / 3, alignment: .leading)
                            
                            Text("Discount Used")
                                .font(.system(size: 12, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("Gray2"))
                                .frame(width: geometry.size.width / 3, alignment: .center)
                            
                            Text("Complete")
                                .font(.system(size: 12, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("Gray2"))
                                .frame(width: geometry.size.width / 3, alignment: .trailing)
                            
                        }
                        .frame(width: geometry.size.width, alignment: .center)
                        
                    }
                    
                }
                else if status == "USED" {
                    
                    VStack(alignment: .center, spacing: 0) {
                        //progress bar
                        ZStack(alignment: .leading) {
                            
                            Capsule().foregroundColor(Color("Gray3"))
                                .frame(width: geometry.size.width, height: 6)
                            
                            Capsule().foregroundColor(Color("ReviewComplementaryGreen"))
                                .frame(width: geometry.size.width / 2, height: 6)
                            
                        }.frame(width: geometry.size.width, height: 6)
                            .padding(.bottom, 8)
                        
                        
                        HStack(alignment: .center, spacing: 0) {
                            
                            Text("Sent")
                                .font(.system(size: 12, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("Dark1"))
                                .frame(width: geometry.size.width / 3, alignment: .leading)
                            
                            Text("In Progress")
                                .font(.system(size: 12, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("Dark1"))
                                .frame(width: geometry.size.width / 3, alignment: .center)
                            
                            Text("Complete")
                                .font(.system(size: 12, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("Gray2"))
                                .frame(width: geometry.size.width / 3, alignment: .trailing)
                            
                        }
                        .frame(width: geometry.size.width, alignment: .center)
                        
                    }
                    
                }
                else if status == "COMPLETE" {
                    
                    VStack(alignment: .center, spacing: 0) {
                        
                        //progress bar
                        Capsule().foregroundColor(Color("ReviewComplementaryGreen"))
                            .frame(width: geometry.size.width, height: 6)
                            .padding(.bottom, 8)
                        
                        
                        HStack(alignment: .center, spacing: 0) {
                            
                            Text("Sent")
                                .font(.system(size: 12, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("Dark1"))
                                .frame(width: geometry.size.width / 3, alignment: .leading)
                            
                            Text("In Progress")
                                .font(.system(size: 12, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("Dark1"))
                                .frame(width: geometry.size.width / 3, alignment: .center)
                            
                            Text("Complete")
                                .font(.system(size: 12, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("Dark1"))
                                .frame(width: geometry.size.width / 3, alignment: .trailing)
                            
                        }
                        .frame(width: geometry.size.width, alignment: .center)
                        
                    }
                    
                }
                else if status == "EXPIRED" {
                    
                    VStack(alignment: .center, spacing: 0) {
                        
                        //progress bar
                        ZStack(alignment: .leading) {
                            
                            Capsule().foregroundColor(Color("Gray3"))
                                .frame(width: geometry.size.width, height: 6)
                            
                            Capsule().foregroundColor(Color.red)
                                .frame(width: 60, height: 6)
                            
                        }.frame(width: geometry.size.width, height: 6)
                            .padding(.bottom, 8)
                        
                        
                        HStack(alignment: .center, spacing: 0) {
                            
                            Spacer()
                            
                            Text("Expired")
                                .font(.system(size: 12, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("Dark1"))
                                .frame(width: geometry.size.width / 3, alignment: .trailing)
                            
                        }
                        .frame(width: geometry.size.width, alignment: .center)
                        
                    }
                    
                }
                
                
            }
            .padding(.horizontal)
        }.padding(.vertical, 12)
        .frame(height: 50)
    }
    
}


struct ReferralTrackerWidget: View {
    
    var title:String
    var amount:String
    var subtitle:String
    var isSelected:Bool
        
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(alignment: .center, spacing: 4) {
                
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(isSelected ? Color.white : Color("Dark1"))
                
                Spacer()
                
            }
            .padding(.bottom, 10)
            .padding(.top, 15)
            .padding(.leading, 15)
            
            HStack(spacing: 0) {
                Spacer()
                VStack(alignment: .center, spacing: 0) {
                    Text(amount)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(isSelected ? Color.white : Color("Dark1"))
                        .padding(.bottom, 6)
                    
                    Text(subtitle)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(isSelected ? Color.white : Color("Gray1"))
                        .padding(.bottom, 16)
                }
                Spacer()
            }
        }.frame(height: 116)
            .background(RoundedRectangle(cornerRadius: 11).foregroundColor(isSelected ? Color("ReferPurple") : Color.white))
    }
}
