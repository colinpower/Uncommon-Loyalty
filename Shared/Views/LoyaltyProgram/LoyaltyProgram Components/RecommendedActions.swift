//
//  RecommendedActions.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/31/22.
//

import SwiftUI

struct RecommendedActions: View {
    
    
    //@ObservedObject var viewModel_Items = ItemsViewModel()
    
    var reviewableItems: [Items]
    
    
    var body: some View {
            
        TabView {
            ForEach(reviewableItems) { item in
                NavigationLink {
                    IntentToReview(itemObject: item)
                } label: {
                    VStack(alignment: .leading, spacing: 0) {
                        
                        //HEIGHT = 60
                        HStack(alignment: .top, spacing: 0) {
                            
                            RoundedRectangle(cornerRadius: 12).strokeBorder()
                                .foregroundColor(Color("Background"))
                                .frame(width: 60, height: 60)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 0)
                                .overlay(
                                    Image("redshorts")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(12)
                                )
                                .padding(.vertical, 10)
                                .padding(.trailing)
                            
                            Text("Write a review for the \(item.name) that you ordered on \(String(item.timestamp))")
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color("Dark1"))
                                .frame(height: 60)
                                .padding(.vertical, 10)
                        }
                        .frame(height: 80)
                        .padding(.horizontal)
                        
                        //HEIGHT = 4
                        Divider().padding(.vertical, 2)
                        
                        //36 height remaining
                        HStack(alignment: .center, spacing: 0) {
                            
                            Spacer()
                            
                            Image(systemName: "clock")
                                .font(.system(size: 16, weight: .medium))
                                .frame(width: 16, height: 16)
                                .foregroundColor(Color("Dark1"))
                                .padding(.trailing, 6)
                            Text("45 sec.")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color("Dark1"))
                                .padding(.trailing)

                            Image(systemName: "star.square.fill")
                                .font(.system(size: 16, weight: .medium))
                                .frame(width: 16, height: 16)
                                .foregroundColor(Color("ReviewTeal"))
                                .padding(.trailing, 6)
                            Text("Earn 250 points")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(Color("ReviewTeal"))
                            
                        }.padding(.vertical, 10)
                        .frame(height: 36)
                        .padding(.horizontal)
                        
                    }.padding(.vertical, 10)
                    .frame(height: 120)
                    .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.white))
                    .padding(.bottom, 40)
                }

                
            }
            
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
            
    }
}

//struct RecommendedActions_Previews: PreviewProvider {
//    static var previews: some View {
//        RecommendedActions()
//    }
//}
