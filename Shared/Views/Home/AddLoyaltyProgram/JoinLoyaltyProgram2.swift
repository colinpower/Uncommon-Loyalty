//
//  JoinLoyaltyProgram2.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/13/22.
//

import SwiftUI

struct JoinLoyaltyProgram2: View {
    
    var screenWidth = UIScreen.main.bounds.width
    
    var company: Companies
    
    @Binding var isAddLoyaltyProgramCarouselActive: Bool
    
    var userID:String
    var email:String
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            //MARK: CONTENT AT TOP (SCREENWIDTH / 1.6 is height)
            GeometryReader { geometry in
                VStack {
                    
                    Image("BlueGoldenRatio")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.width / 1.6)
                    
                }.frame(width: geometry.size.width, height: geometry.size.width / 1.6)
            }.padding()
            .frame(width: screenWidth, height: screenWidth/1.6)
            
            //MARK: PROMPT (80)
            Text(company.companyName)
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(Color("Dark1"))
                .padding()
            
            Text("We love our influencers")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Color("Dark1"))
                .padding()
            
            Text("<< MORE CONTENT HERE >>")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Color("Dark1"))
                .padding()
            
            
            
            Spacer()
            
            NavigationLink {
                JoinLoyaltyProgram3(company: company, isAddLoyaltyProgramCarouselActive: $isAddLoyaltyProgramCarouselActive, userID: userID, email: email)
            } label: {
                HStack {
                    Spacer()
                    Text("Continue")
                        .foregroundColor(Color.white)
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .padding(.vertical, 16)
                    Spacer()
                }.clipShape(Capsule())
                 .background(Capsule().foregroundColor(Color("ReferPurple")))
                 .padding(.horizontal)
                 .padding(.horizontal)
                 .padding(.bottom, 60)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        
        
    }
}
