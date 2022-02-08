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
    var points: Int
    var status: String
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(status + "Tier").font(.footnote).foregroundColor(Color.gray)
                Spacer()
            }
            HStack{
                Image(systemName: "person.crop.circle")
                    .foregroundColor(.black)
                    .font(.system(size: 30))
                Text(company).font(.system(size: 30)).foregroundColor(Color.black.opacity(0.7))
                Spacer()
                Text(String(points)).font(.system(size: 30)).foregroundColor(Color.black.opacity(0.7))
            }
            HStack{
                Spacer()
                Text("Points").font(.footnote).foregroundColor(Color.black.opacity(0.7))
            }
            
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 5).fill(status == "Silver" ? Color.blue: Color.gray))
        
        .padding(.horizontal, 12)
    }
}

struct CompanyRewardsProgram_Previews: PreviewProvider {
    static var previews: some View {
        RewardsProgramWidget(company: "Company", points: 14000, status: "Silver")
    }
}
