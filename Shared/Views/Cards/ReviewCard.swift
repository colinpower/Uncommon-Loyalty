//
//  ReviewCard.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/29/22.
//

import SwiftUI

struct ReviewCard: View {
    
    var reviewerProfilePic:String       //the path to the pro pic in settings
    var reviewerFirstName:String
    var reviewerLastName:String
    
    var reviewTimestamp:Int
    
    var reviewRating:Int
    
    var reviewTitle:String
    var reviewBody:String
    
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            //MARK: Top section
            HStack(alignment: .top, spacing: 0) {
                
                Image("Athleisure LA")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .padding(.bottom, 30)
                    .frame(width: 60, height: 90, alignment: .leading)
                    .padding(.trailing).padding(.trailing)
                    
                VStack(alignment: .leading, spacing: 0) {
                    
                    let reviewerName:String = reviewerFirstName + " " + reviewerLastName.prefix(1) + "."
                    
                    let reviewTime:String = "on " + convertTimestampToString(timestamp: reviewTimestamp)
                    
                    Text(reviewerName)
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(Color("Dark1"))
                        .padding(.bottom, 4)
                    
                    Text(reviewTime)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color("Gray1"))
                        .padding(.bottom, 14)
                    
                    HStack(alignment: .center, spacing: 2) {
                        ForEach(0..<5) { i in
                            if i < reviewRating {
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.yellow)
                                    .font(.system(size: 20, weight: .regular))
                            } else {
                                Image(systemName: "star")
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 20, weight: .regular))
                            }
                        }
                    }.padding(.bottom, 16)
                    
                }.frame(height: 90)
                
                
                Spacer()
            }
            .padding(.bottom, 20)
            
            //MARK: Review title / body section...
            VStack(alignment: .leading, spacing: 0) {
                Text(reviewTitle)
                    .font(.system(size: 24, weight: .semibold))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color("Dark1"))
                    .padding(.bottom, 8)
                
                Text(reviewBody)
                    .font(.system(size: 16, weight: .regular))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color("Dark1"))
                    .padding(.bottom, 8)
            }
            
        }.padding()
        
        
    }
}

