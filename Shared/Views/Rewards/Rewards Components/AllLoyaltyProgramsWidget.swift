//
//  AllLoyaltyProgramsWidget.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/6/22.
//

import SwiftUI

struct AllLoyaltyProgramsWidget: View {


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
                .frame(width: 36, height: 36, alignment: .center)
                .clipped()
                .cornerRadius(8)
                .padding(.trailing, 6)
                .padding(.bottom, 5)
            
            //MARK: COMPANY NAME AND STATUS
            VStack(alignment: .leading, spacing: 3) {
                Text(company)
                    .foregroundColor(Color("Dark1"))
                    .font(.system(size: 16, weight: .medium))
                Text(shortDescription)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(Color("Gray1"))
            }
                .padding(.top, 2)
                .padding(.bottom, 2)
                .frame(height: 36)
            
            Spacer()
            
            //MARK: CALL TO ACTION
            VStack(alignment: .trailing, spacing: 0) {
                Spacer()
                if isAlreadyJoined {
                    Text("View")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 60)
                        .padding(.vertical, 5)
                        .background(Color("ThemePrimary"))
                        .clipShape(Capsule())
                        .padding(.vertical, 6)
                } else {
                    Text("Join")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("ThemeAction"))
                        .frame(width: 60)
                        .padding(.vertical, 5)
                        .background(Color("ThemeLight"))
                        .clipShape(Capsule())
                        .padding(.vertical, 6)
                    
                }
                Spacer()
            }
            .frame(height: 36)
                
            Image(systemName: "chevron.right")
                .foregroundColor(Color("Gray3"))
                .font(Font.system(size: 12, weight: .medium))
        }
            
            if !isLastItemInList {
                Divider()
                    .padding(.leading)
                    .padding(.leading, 40)
                    .padding(.vertical, 10)
            }
        }
    }
    
    
}

