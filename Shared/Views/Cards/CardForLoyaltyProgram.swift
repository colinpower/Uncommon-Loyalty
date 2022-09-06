//
//  CardForLoyaltyProgram.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/6/22.
//

import SwiftUI

struct CardForLoyaltyProgram: View {
    
    var cardColor:Color
    var textColor:Color
    var companyImage:String
    var companyName:String
    
    var currentDiscountAmount:String
    var currentDiscountCode:String
    
    var userFirstName:String
    var userLastName:String
    
    var userCurrentTier:String
    
    var discountCardDescription:String   //e.g. "Default Card"
    
    
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            GeometryReader { geometry in
                
                ZStack(alignment: .center) {
                    
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(cardColor)
                        .frame(width: geometry.size.width, height: geometry.size.width / 1.6)
                        .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 5)
                    
                    VStack(alignment: .center, spacing: 0) {
                        HStack(alignment: .center, spacing: 0) {
                            Image(companyImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40, alignment: .leading)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .padding(.trailing, 6)
                            Text(companyName)
                                .font(.system(size: 24))
                                .fontWeight(.medium)
                                .foregroundColor(textColor)
                                .padding(.vertical, 8)
                            Spacer()
                            Text(currentDiscountAmount)
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                                .foregroundColor(textColor)
                        }
                        .frame(height: 40)
                        .padding([.top, .horizontal])
                        
                        Spacer()
                        
                        HStack {
                            
                            Text(currentDiscountCode)
                                .font(.system(size: 60, weight: .bold, design: .rounded))
                                .foregroundColor(textColor)
                            
                        }.frame(width: geometry.size.width, height: 60, alignment: .center)
                        
                        Spacer()
                        
                        HStack(alignment: .bottom, spacing: 0) {
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text(userFirstName.uppercased())
                                    .font(.system(size: 16))
                                    .fontWeight(.medium)
                                    .foregroundColor(.gray)
                                    .padding(.bottom, 8)
                                
                                Text(userCurrentTier.uppercased() + " since 2022")
                                    .font(.system(size: 14))
                                    .fontWeight(.regular)
                                    .foregroundColor(.gray)
                            }.frame(height: 38)
                            
                            Spacer()
                            
                            Text(discountCardDescription.uppercased())
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.gray)
                        }
                        .frame(height: 38)
                        .padding([.bottom, .horizontal])

                    }
                    
                    
                }
            }.padding()
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.6)
    }
}

