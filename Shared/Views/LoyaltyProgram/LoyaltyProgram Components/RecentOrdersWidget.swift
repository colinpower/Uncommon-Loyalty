//
//  RecentOrdersWidget.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/6/22.
//

import SwiftUI


struct RecentOrdersWidget: View {
    
    var item: String
    var timestamp: Int
    var reviewID: String
    var colorToShow: Color
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Image(systemName: "bag.circle.fill")
                    .font(.system(size: 45, weight: .medium))
                    .foregroundColor(colorToShow)
                    .padding(.vertical, 15)
                    .padding(.trailing, 12)
                    .frame(height: 75)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(item)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color("Dark1"))
                    Text(convertTimestampToString(timestamp: timestamp))
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(Color("Gray1"))
                }
                .padding(.vertical, 19)
                .frame(height: 75)
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 2) {
                    Text("+ 750")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("ThemePrimary"))
                    Text("$75")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(Color("Gray1"))
                        .padding(2)
                        .background(RoundedRectangle(cornerRadius: 2).foregroundColor(Color("Background")))
                }
                .padding(.top, 21)
                .padding(.bottom, 21)
                .padding(.trailing, 12)
                .frame(height: 75)
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color("Gray2"))
                    .padding(.trailing, 8)
                
            }.frame(height: 75)
            Divider()
        }
        .frame(height: 77)
        .padding(.leading)
    }
}
