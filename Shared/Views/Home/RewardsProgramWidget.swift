//
//  CompanyRewardsProgram.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 1/17/22.
//

// This file is responsible for formatting the company RewardsProgram on the Home page

import SwiftUI

struct RewardsProgramWidget: View {

    
    var company: String
    var image: String
    var points: Int
    var status: String
    
    var body: some View {
        VStack {
            //MARK: Tier
//            HStack {
//                Spacer()
//                Text(status + "Tier").font(.footnote).foregroundColor(Color.gray)
//                Spacer()
//            }
            
            //MARK: content
            HStack{
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36, alignment: .center)
                    .clipped()
                    .cornerRadius(10)
                    .padding(.trailing, 12)
//                Image(systemName: "person.crop.circle")
//                    .foregroundColor(.black)
//                    .font(.system(size: 30))
                Text(company).font(.headline)
                    .foregroundColor(Color.black.opacity(0.7))
                Spacer()
                VStack(alignment: .trailing) {
                    Text(String(points) + " Points")
                        .font(.body)
                        .foregroundColor(Color.black)
                    Text(status == "None" ? "" : String(status) + " Status")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.5))
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 5).fill(status == "Silver" ? Color.white: Color.white))
        .padding(.horizontal, 12)
    }
}

struct CompanyRewardsProgram_Previews: PreviewProvider {
    static var previews: some View {
        RewardsProgramWidget(company: "Company", image: "AthleisureLA", points: 14000, status: "Silver")
    }
}
