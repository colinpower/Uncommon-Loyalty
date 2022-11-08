//
//  NewLoyaltyProgramWidget.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/6/22.
//

import SwiftUI

struct NewLoyaltyProgramWidget: View {


    var image: String
    var company: String
    var shortDescription: String
    var joiningBonus: Int
    var joiningBonusType: String
    var isLastItemInList:Bool
    
    var isAlreadyJoined:Bool
    
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
                .padding(.bottom, 13)
                .frame(height: 62)
            
            Spacer()
            
            //MARK: CALL TO ACTION
            Text("Join")
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundColor(Color("ThemeAction"))
                .frame(width: 72)
                .padding(.vertical, 6)
                .background(Color("ThemeLight"))
                .clipShape(Capsule())
                .padding(.vertical, 17)
                
            Image(systemName: "chevron.right")
                .foregroundColor(Color("Gray3"))
                .font(Font.system(size: 15, weight: .semibold))
        }
            
            if !isLastItemInList {
                Divider()
                    .padding(.leading)
                    .padding(.leading, 62)
                    .padding(.vertical, 10)
            }
        }
    }
    
    
}

