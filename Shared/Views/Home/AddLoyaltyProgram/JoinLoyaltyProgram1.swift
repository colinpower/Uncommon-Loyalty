//
//  JoinLoyaltyProgram1.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/13/22.
//

import SwiftUI
import AVKit

struct JoinLoyaltyProgram1: View {
    
    @State private var isShowingVideo = false
    @State var player = AVPlayer(url: Bundle.main.url(forResource: "Streetwear", withExtension: "mov")!)
    
    var screenWidth = UIScreen.main.bounds.width
    
    var company: Companies
    
    @Binding var isAddLoyaltyProgramCarouselActive: Bool
    
    var userID:String
    var email:String
    
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .center, spacing: 0) {
                
                //MARK: CONTENT AT TOP (SCREENWIDTH / 1.6 is height)
                GeometryReader { geometry in
                    VStack {
                        
                        VideoPlayer(player: player)
                            .frame(width: geometry.size.width, height: geometry.size.width / 1.6)
                            .cornerRadius(12)
                        
                        
//                        Image("BlueGoldenRatio")
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: geometry.size.width, height: geometry.size.width / 1.6)
                        
                    }.frame(width: geometry.size.width, height: geometry.size.width / 1.6)
                }.padding()
                    .frame(width: screenWidth, height: screenWidth/1.6)
                
                //MARK: PROMPT (80)
                Text(company.companyName)
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(Color("Dark1"))
                    .padding()
                
                Text("A message from our founder")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color("Dark1"))
                    .padding()
                
                Label {
                    Text("10 seconds")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                } icon: {
                    Image(systemName: "clock")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                NavigationLink {
                    JoinLoyaltyProgram2(company: company, isAddLoyaltyProgramCarouselActive: $isAddLoyaltyProgramCarouselActive, userID: userID, email: email)
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
}
