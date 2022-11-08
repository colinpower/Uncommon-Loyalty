//
//  History.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/8/22.
//

import SwiftUI

struct History: View {
    
    
    var userID: String
    var companyID: String
    
    @Binding var isHistoryActive:Bool
    
    @ObservedObject var transactionsViewModel = TransactionsViewModel()
    
    var body: some View {
        GeometryReader { geometry in
                        
            ZStack(alignment: .top) {
                
                //MARK: Background color
                Color("Background")
                
                //the content on top of the background
                VStack(alignment: .leading) {
                    
                    //MARK: Header
                    SheetHeader(title: "Your History", isActive: $isHistoryActive)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        //MARK: Activity (Purchases, Spent Points, Reviews, Referrals)
                        VStack(alignment: .leading) {
                            
                            //For each History item...
                            ForEach(transactionsViewModel.snapshotOfTransactionsForCompany.prefix(15)) { transaction in
                                MyHistoryItem(type: transaction.type, timestamp: transaction.timestamp, pointsEarnedOrSpent: transaction.pointsEarned, colorToShow: Color("ThemePrimary"))
                            }
                            HStack {
                                Spacer()
                                Text("More")
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("ThemePrimary"))
                                Spacer()
                            }
                        }.padding()
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
                        .padding(.horizontal)
                        .padding(.bottom)
                            
                        }
                    }
            }
        }.ignoresSafeArea()
        .onAppear {
            self.transactionsViewModel.getSnapshotOfTransactionsForCompany(userID: userID, companyID: companyID)
        }
    }
}

struct History_Previews: PreviewProvider {
    static var previews: some View {
        History(userID: "", companyID: "zKL7SQ0jRP8351a0NnHM", isHistoryActive: .constant(true))
    }
}




//MARK: MY HISTORY
//This struct formats the discount codes that are available
struct MyHistoryItem: View {
    
    var type: String
    var timestamp: Int
    var pointsEarnedOrSpent: Int
    var colorToShow: Color
    
    var iconToShow: String {
        switch type {
            case "REFERRAL":
                return "person.2.fill"
            case "REVIEW":
                return "text.bubble.fill"
            case "ORDER":
                return "signature"
            case "DISCOUNTCODE":
                return "dollarsign.circle.fill"
            default:
                return "bag.fill"
        }
    }
    
    var textToShow: String {
        switch type {
            case "REFERRAL":
                return "Referral bonus"
            case "REVIEW":
                return "Review bonus"
            case "ORDER":
                return "Purchase"
            case "DISCOUNTCODE":
                return "Redeemed points"
            default:
                return "bag.fill"
        }
    }
    
    var body: some View {
        
        HStack {
            Image(systemName: iconToShow)
                .foregroundColor(colorToShow)
                .font(.system(size: 32))
            VStack(alignment: .leading, spacing: 3) {
                HStack(alignment: .center) {
                    Text(textToShow)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Dark1"))
                    Spacer()
                    Text(convertTimestampToString(timestamp: timestamp))
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Dark1"))
                }
                Text(String(pointsEarnedOrSpent))
                    .font(Font.system(size: 16, weight: .regular))
                    .foregroundColor(Color("Gray1"))
                
            }
        }.padding(.bottom)
    }
}
