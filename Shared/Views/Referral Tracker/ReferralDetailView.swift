//
//  ReferralDetailView.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/26/22.
//

import SwiftUI


//MARK: HACK necessary to pass the correct image to the share sheet
enum ActiveSheetiMessageInTrackerTab: String, Identifiable { // <--- note that it's now Identifiable
    case iMessageShareSheet, moreOptionsShareSheet
    var id: String {
        return self.rawValue
    }
}


struct ReferralDetailView: View {
    
    var referral: Referrals
    
    @State var activeSheetiMessageInTrackerTab: ActiveSheetiMessageInTrackerTab? = nil
    
    @State private var customReferralCardSnapshotInTrackerTab: UIImage? = nil
//    customReferralCardSnapshotInTrackerTab = discountCardForReferralInTrackerTab.snapshot()
    
    var options: [[Any]] = [
        [Color("ReviewTealImage"), Color("Yoga"), "normal", "Robin"],
        [Color("ThemeLight"), Color("ThemeAction"), "normal", "Uncommon"],
        [Color.green, Color.white, "normal", "Green"],
        [Color.yellow, Color.gray, "normal", "Yellow"],
        [Color.blue, Color.white, "normal", "Blue"],
        [Color("Gold1"), Color.white, "engraved", "Gold"],
        [Color.white, Color.white, "engraved", "White"],
        [Color("CardTeal"), Color.white, "engraved", "Teal"]
    ]
    
    let currentTimestamp = Int(round(Date().timeIntervalSince1970))
    
    var statusArray: [String] {
        switch referral.status.status {
        case "CREATED":
            //check to see if there's an expiration date
            if referral.offer.expirationTimestamp == -1 {
                
                //this means there's no expiration, so we give 90 days
                let expiryTimestamp = referral.status.timestampCreated + 90 * 86400
                
                //check to see if it hasn't expired yet
                if expiryTimestamp > currentTimestamp {
                    
                    return ["SENT", "Sent. Expires on " + convertTimestampToString(timestamp: expiryTimestamp, format: "MMM d") + "."]
                } else {
                    
                    return ["EXPIRED-PENDING", "Expired on " + convertTimestampToString(timestamp: expiryTimestamp, format: "MMM d") + "."]
                    
                }
                
            } else {
                
                //this means there's an expiration
                let expiryTimestamp = referral.offer.expirationTimestamp
                
                //check to see if it hasn't expired yet
                if expiryTimestamp > currentTimestamp {
                    
                    return ["SENT", "Sent. Expires on " + convertTimestampToString(timestamp: expiryTimestamp, format: "MMM d") + "."]
                } else {
                    
                    return ["EXPIRED-PENDING", "Expired on " + convertTimestampToString(timestamp: expiryTimestamp, format: "MMM d") + "."]
                    
                }
                
            }
            
        case "USED":
            
            let completionTimestamp = referral.status.timestampUsed == -1 ? referral.status.timestampUsed : referral.status.timestampUsed + referral.status.timeWaitingForReturnInDays * 86400
            
            //check to see if the completionTimestamp has happened already
            if (completionTimestamp <= referral.status.timestampUsed ) {
                
                return ["COMPLETE-PENDING", "Referred! Your " + String(referral.reward.rewardAmount) + " points will be added to your account shortly."]
                
            } else {
                
                return ["USED", "Discount used! You will earn " + String(referral.reward.rewardAmount) + " points if this item is not returned."]
                
            }
            
        case "COMPLETE":
            
            return ["COMPLETE", "Referred! " + String(referral.reward.rewardAmount) + " points will be added to your account shortly."]
            
        case "EXPIRED":
            
            let expiryTimestamp = referral.offer.expirationTimestamp == -1 ? referral.status.timestampCreated + 90 * 86400 : referral.offer.expirationTimestamp

            return ["EXPIRED", "Expired on " + convertTimestampToString(timestamp: expiryTimestamp, format: "MMM d") + "."]
            
        default:
            return ["DEFAULT", "Status Pending"]
        }
    }
    
    
    //Use this variable to create an image
    var discountCardForReferralInTrackerTab: some View {
        
        DiscountCardForReferralImageCreation(designSelection1: options[referral.card.color], companyImage: "AthleisureLA-Icon-Teal", companyName: referral.card.companyName, discountAmount: String(referral.offer.rewardAmount), discountCode: referral.card.discountCode, recipientFirstName: referral.recipient.firstName, recipientLastName: referral.recipient.lastName)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.6)
        
    }
    
    @State var customReferralURLForDetailView:String = ""
        
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    //DESIGN SELECTION IS A WEIRD [[ANY]] ARRAY
                    DiscountCardForReferral(designSelection: options[Int(referral.card.color) ?? 1], companyImage: "Athleisure LA", companyName: referral.card.companyName, discountAmount: "$" + String(referral.offer.rewardAmount), discountCode: String(referral.card.discountCode), recipientFirstName: referral.recipient.firstName, recipientLastName: referral.recipient.lastName)
                        .padding(.vertical)
                        //.padding(.bottom)
                        //.padding(.top, 100)
                    
                    HStack(alignment: .top, spacing: 20) {
                        
                        Text("Referral bonus")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(Color("Gray1"))
                        Spacer()
                        Text(String(referral.reward.rewardAmount) + " points")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor((statusArray[0] == "COMPLETE" || statusArray[0] == "COMPLETE-PENDING") ? Color("ReferPurple") : Color("Dark1"))

                        
                    }.padding()
                    .background(RoundedRectangle(cornerRadius: 11).foregroundColor(Color.white))
                    .clipShape(RoundedRectangle(cornerRadius: 11))
                    .shadow(radius: 5)
                    .padding()
                    .padding(.bottom)
                    
                    Text(statusArray[1])
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color("Dark1"))
                        .multilineTextAlignment(.leading)
                        .padding()
                    
//                    ReferralTrackingCardProgressBar(status: referral.status.status)
//                        .frame(height: 50)
//                        .padding()
//                        .padding(.horizontal, 4)

                    
                    timelineOfReferral
                        .background(RoundedRectangle(cornerRadius: 11).foregroundColor(Color.white))
                        .clipShape(RoundedRectangle(cornerRadius: 11))
                        .shadow(radius: 5)
                        .padding()
                        .padding(.bottom)

                }
            }
            
            Spacer()
            
            if !(statusArray[0] == "COMPLETE" || statusArray[0] == "COMPLETE-PENDING") {
             
                resendButtons
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                    .frame(width: UIScreen.main.bounds.width, height: 110)
                    .background(Rectangle().foregroundColor(Color.white).shadow(color: Color("Gray2"), radius: 2, x: 0, y: -1))
                
            }
            
        }
        .edgesIgnoringSafeArea([.horizontal, .bottom])
        .navigationBarTitle(referral.recipient.firstName + "'s Referral", displayMode: .inline)
        .background(Color("Background"))
        .onAppear {
            self.customReferralCardSnapshotInTrackerTab = discountCardForReferralInTrackerTab.snapshot()
            
            self.customReferralURLForDetailView = "https://" + referral.ids.domain + "/discount/" + referral.card.discountCode + "?redirect=/products/" + referral.ids.handle
            
        }
        .sheet(item: $activeSheetiMessageInTrackerTab) { [customReferralCardSnapshotInTrackerTab] sheet in

            switch sheet {
            case .iMessageShareSheet:

                //confirm that you've been able to convert the card into an image
                if let unwrappedImage = customReferralCardSnapshotInTrackerTab {
                    
                    let finalMessage = referral.card.customMessage + " " + customReferralURLForDetailView

                    MessageView(recipient: referral.recipient.phone, photo: unwrappedImage, messageToRecipient: finalMessage)

                    //ReferralShareSheet(activityItems: ["Hey, I created a discount code for you!", unwrappedImage])
                                       //activityItems: ["Hey, I created a discount code for you!", customCardViewSnapshot as Any ]
                }
            default:

                if let unwrappedImage = customReferralCardSnapshotInTrackerTab {
                    
                    let finalMessage = referral.card.customMessage + " " + customReferralURLForDetailView
                    
                    ReferralShareSheet(activityItems: [finalMessage, unwrappedImage])
                                       //activityItems: ["Hey, I created a discount code for you!", customCardViewSnapshot as Any ]
                }

            }
        }
    }
    
    
    var resendButtons: some View {
            
            HStack(alignment: .center, spacing: 0) {
                
                Text("Send again")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(Color("Dark1"))
                    .frame(height: 60, alignment: .leading)
                    .padding(.top, 10)
                
                Spacer()

                
                Button(action: {
                    
                    //isShowingMessages = true
                    customReferralCardSnapshotInTrackerTab = discountCardForReferralInTrackerTab.snapshot()
                    
                    self.activeSheetiMessageInTrackerTab = .iMessageShareSheet
                    
                }) {
                    HStack (alignment: .center) {
                        
                        Text("iMessage")
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                            .foregroundColor(Color.white)
                            .padding(.trailing, 2)
                        
                        Image(systemName: "arrow.up.forward")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color.white)
                        
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .background(RoundedRectangle(cornerRadius: 6).foregroundColor(Color.green))
                    .padding(.top, 10)
                    .frame(height: 70, alignment: .center)
                }
                .padding(.trailing)
                
                
                Button(action: {
                    
                    //isShowingMessages = true
                    customReferralCardSnapshotInTrackerTab = discountCardForReferralInTrackerTab.snapshot()
                    
                    self.activeSheetiMessageInTrackerTab = .moreOptionsShareSheet
                    
                }) {
                    HStack (alignment: .center) {
                        
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(Color.blue)
                        
                        Text("Share")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundColor(Color.blue)

                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 10)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .background(RoundedRectangle(cornerRadius: 6).foregroundColor(Color.white))
                    .padding(.top, 10)
                    .frame(height: 70, alignment: .center)
                }
                
                
                
                
            }
            .frame(height: 70)
    }
    
    var rewardForSender: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(alignment: .center, spacing: 4) {
                
                Text("Referral bonus")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color("Dark1"))
                
                Spacer()
                
            }
            .padding(.top, 15)
            .padding(.leading, 15)
            .padding(.bottom, 30)
            
            HStack(spacing: 0) {
                Spacer()
                VStack(alignment: .center, spacing: 0) {
                    Text(String(referral.reward.rewardAmount))
                        .font(.system(size: 26, weight: .bold, design: .rounded))
                        .foregroundColor((statusArray[0] == "COMPLETE" || statusArray[0] == "COMPLETE-PENDING") ? Color("Dark1") : Color("Gray1"))
                        .padding(.bottom, 2)
                    
                    Text("Points")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor((statusArray[0] == "COMPLETE" || statusArray[0] == "COMPLETE-PENDING") ? Color("Dark1") : Color("Gray1"))
                        .padding(.vertical)
                    Spacer()
                }
                Spacer()
            }
        }
    }
    
    var headsUpDate: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(alignment: .center, spacing: 4) {
                
                Text("Expires")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color("Dark1"))
                
                Spacer()
                
            }
            .padding(.top, 15)
            .padding(.leading, 15)
            .padding(.bottom, 30)
            
            HStack(spacing: 0) {
                Spacer()
                VStack(alignment: .center, spacing: 0) {
                    
                    let expiry = referral.offer.expirationTimestamp == -1 ? referral.status.timestampCreated + 90 * 86400 : referral.offer.expirationTimestamp
                    
                    Text(convertTimestampToString(timestamp: expiry, format: "MMM d"))
                        .font(.system(size: 26, weight: .bold, design: .rounded))
                        .foregroundColor(Color("Dark1"))
                        .padding(.bottom, 4)
                    
                    Text("")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color.white)
                        .padding(.vertical)
                    Spacer()
                }
                Spacer()
            }
        }
    }
    
    var currentStateOfReferral: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(alignment: .center, spacing: 4) {
                
                Text("Status")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color("Dark1"))
                
                Spacer()
                
            }
            .padding(.top, 15)
            .padding(.leading, 15)
            .padding(.bottom, 30)
            
            HStack(spacing: 0) {
                Spacer()
                VStack(alignment: .center, spacing: 0) {
                    
                    let expiry = referral.offer.expirationTimestamp == -1 ? referral.status.timestampCreated + 90 * 86400 : referral.offer.expirationTimestamp
                    
                    Text(referral.status.status)
                        .font(.system(size: 26, weight: .bold, design: .rounded))
                        .foregroundColor(Color("Dark1"))
                        .padding(.bottom, 4)
                    
                    Text("")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color.white)
                        .padding(.vertical)
                    Spacer()
                }
                Spacer()
            }
        }
    }
    
    
    var timelineOfReferral: some View {
        
        HStack(alignment: .top, spacing: 0) {
            
            verticalProgressTimeline(status: statusArray[0], heightParam: CGFloat(164))
                .frame(width: 10, height: 180)
                .padding(.leading, 20)
                .padding(.vertical, 25)
                .padding(.trailing, 20)
            
            VStack(alignment: .leading, spacing: 0) {
                
                Text("Sent to " + referral.recipient.firstName)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color("Dark1"))
                    .padding(.top, 2)
                    .padding(.bottom, 4)
                Text("On " + convertTimestampToString(timestamp: referral.status.timestampCreated))
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(Color("Gray1"))
                
                Spacer()
                
                let tempVar2 = referral.status.status == "USED" || referral.status.status == "COMPLETE"
                
                Text("Used by " + referral.recipient.firstName)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(tempVar2 ? Color("Dark1") : Color("Gray3"))
                    .padding(.bottom, 4)
                Text(tempVar2 ? "On " + convertTimestampToString(timestamp: referral.status.timestampUsed) : "Incomplete")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(tempVar2 ? Color("Gray1") : Color("Gray3"))
            
                Spacer()
                
                let tempVar3 = referral.status.status == "COMPLETE"
                Text("You earned " + String(referral.reward.rewardAmount) + " points!")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(tempVar3 ? Color("Dark1") : Color("Gray3"))
                    .padding(.bottom, 4)
                Text(tempVar3 ? "On " + convertTimestampToString(timestamp: referral.status.timestampComplete) : "Incomplete")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(tempVar3 ? Color("Gray1") : Color("Gray3"))
                
            }.frame(height: 190)
            .padding(.vertical, 20)
            .padding(.trailing, 20)
            
            Spacer()
            
        }.frame(height: 230)
    }
}



struct verticalProgressTimeline: View {
    
    var status: String
    
    var heightParam: CGFloat
    
    var progressAmount:Int {
        switch status {
        case "CREATED":
            return 0
        case "USED":
            return 1
        case "COMPLETE-PENDING":
            return 2
        case "COMPLETE":
            return 2
        case "EXPIRED-PENDING":
            return -1
        case "EXPIRED":
            return -1
        default:
            return 0
        }
    }
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            if progressAmount == -1 {
                RoundedRectangle(cornerRadius: 1).foregroundColor(Color.red)
                    .frame(width: 1, height: heightParam)
                
            } else if progressAmount == 0 {
                RoundedRectangle(cornerRadius: 1).foregroundColor(Color("Gray3"))
                    .frame(width: 1, height: heightParam)
                
                VStack(alignment: .center, spacing: 0) {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color("ReferPurple"))
                    Spacer()
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color("Gray3"))
                    Spacer()
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color("Gray3"))
                }.frame(width: 10, height: heightParam)
                   
            } else if progressAmount == 1 {
                
                RoundedRectangle(cornerRadius: 1).foregroundColor(Color("Gray3"))
                    .frame(width: 1, height: heightParam)
                
                RoundedRectangle(cornerRadius: 1).foregroundColor(Color("ReferPurple"))
                    .frame(width: 1, height: heightParam / 2)
                
                VStack(alignment: .center, spacing: 0) {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color("ReferPurple"))
                    Spacer()
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color("ReferPurple"))
                    Spacer()
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color("Gray3"))
                }.frame(width: 10, height: heightParam)
                
            } else {
                
                RoundedRectangle(cornerRadius: 1).foregroundColor(Color("ReferPurple"))
                    .frame(width: 1, height: heightParam)
                
                VStack(alignment: .center, spacing: 0) {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color("ReferPurple"))
                    Spacer()
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color("ReferPurple"))
                    Spacer()
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color("ReferPurple"))
                }.frame(width: 10, height: heightParam)
            }
           
        }.frame(width: 10, height: heightParam)
        
    }
    
    
    
}
