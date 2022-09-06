//
//  RecommendedLoyaltyProgramWidget.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/6/22.
//

import SwiftUI

struct RecommendedLoyaltyProgramWidget: View {


    var image: String
    var company: String
    var shortDescription: String
    var joiningBonus: Int
    var joiningBonusType: String
    var isLastItemInList:Bool
    
    var numOfRecentOrders:Int
    
    var body: some View {

        VStack(alignment: .leading, spacing: 0) {
            HStack (alignment: .center) {
            
            //MARK: COMPANY ICON
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 62, height: 62, alignment: .center)
                .clipped()
                .cornerRadius(8)
                .padding(.trailing, 6)
                .padding(.bottom, 5)
            
            //MARK: COMPANY NAME AND STATUS
            VStack(alignment: .leading, spacing: 6) {
                Text(company)
                    .foregroundColor(Color("Dark1"))
                    .font(.system(size: 16, weight: .medium))
                Text(shortDescription)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color("Gray1"))
            }
                .padding(.top, 13)
                .padding(.bottom, 18)
                .frame(height: 67)
            
            Spacer()
            
            //MARK: CURRENT POINTS
            VStack(alignment: .trailing, spacing: 0) {
                
                Text("Get " + String(joiningBonus) + String(joiningBonusType == "PERCENT" ? "%" : " Points"))
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("ThemeAction"))
                    .frame(width: 72)
                    .padding(.vertical, 6)
                    .background(Color("ThemeLight"))
                    .clipShape(Capsule())
                    .padding(.top, 13)
                    .padding(.bottom, 3)
                
                Text("Available points")
                    .font(.system(size: 10))
                    .fontWeight(.regular)
                    .foregroundColor(Color("Gray1"))
                Spacer()
            }
            .frame(height: 67)
                
            Image(systemName: "chevron.right")
                .foregroundColor(Color("Gray3"))
                .font(Font.system(size: 15, weight: .semibold))
        }
            
            Divider()
                .padding(.leading)
                .padding(.leading, 62)
                .padding(.vertical, 10)
            
            Text(String(numOfRecentOrders) + " recent orders")
                .foregroundColor(Color("Dark2"))
                .font(Font.system(size: 15, weight: .medium))
            
            
            if !isLastItemInList {
                Divider()
                    .padding(.vertical, 10)
            }
        }
    }
    
    
}

