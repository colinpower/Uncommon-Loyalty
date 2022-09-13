//
//  IntentToRefer.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/2/22.
//

import SwiftUI

struct IntentToRefer: View {
    
    //Environment
    
    //ViewModels
    @ObservedObject var itemsViewModel = ItemsViewModel()
    
    //State - need to create one that triggers the reviews flow
    @State var isShowingReferExperience: Bool = false
    @State var isShowingItemSheet:Bool = false
     
    
    //Required variables
    var itemObject:Items
    
    
    var body: some View {
            
        VStack(spacing: 0) {
        
            //MARK: HEADER (STAR + "REFER" AT THE TOP)
            VStack(alignment: .leading, spacing: 8) {
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundColor(Color("ReferPurple"))
                HStack(alignment: .bottom, spacing: 0) {
                    Text("Refer")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(Color("Dark1"))
                    Spacer()
                }
            }.padding([.horizontal, .top])
        
            //MARK: CONTENT
            List {
                
                //MARK: PREVIOUS REVIEW SECTION
                Section(header: Text("Your 5 star review")) {
                    
                    //preview of review
                    HStack(alignment: .center) {
                        
                        //image
                        Image("redshorts")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4)
                            .cornerRadius(32)
                            .padding(.trailing).padding(.trailing)
                        
                        //empty review
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Joggers 2.0")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.black)
                                .padding(.bottom, 4)
                            
                            Text("Absolutely amazing! I can't wait to get another pair")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .padding(.bottom)
                            
                            HStack(alignment: .center) {
                                Image(systemName: "star.fill")
                                Image(systemName: "star.fill")
                                Image(systemName: "star.fill")
                                Image(systemName: "star.fill")
                                Image(systemName: "star.fill")
                            }.font(.system(size: 18))
                            .foregroundColor(Color.yellow)

                        }
                    }
                    HStack {
                        Text("Colin P.")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color("Dark1"))
                        Spacer()
                        Label {
                            Text("Verified Buyer")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.green)
                        } icon: {
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.green)
                        }.foregroundColor(.green)
                    }
                    
                }
                
            }.frame(height: 250)
            
            
//                Section {
//                    //order details
//                    Button {
//                        isShowingItemSheet.toggle()
//                    } label: {
//                        Text("Order details")
//                            .foregroundColor(.black)
//                            .font(.system(size: 16, weight: .medium))
//                    }.sheet(isPresented: $isShowingItemSheet) {
//                        isShowingItemSheet = false
//                    } content: {
//                        Item(itemID: itemObject.itemID)
//                    }
//                }
                                
                //MARK: VIEW COMPANY SECTION
//                Section {
//                    //company -> about us page
//                    NavigationLink {
//                        ProfileTEMP()
//                    } label: {
//                        HStack {
//
//                            Image("Athleisure LA")
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: 28, height: 28, alignment: .center)
//                                .clipped()
//                                .cornerRadius(7)
//                                .padding(.horizontal, 2)
//
//                            Text("Athleisure LA")
//                                .font(.system(size: 16))
//                                .foregroundColor(.black)
//                            Spacer()
//
//                        }
//
//                    }
//                }
            
            VStack(alignment: .leading) {
                
                //Text("NOTE TO SELF::: HAVE A PAGE 0 where it explains that you're going to be creating a discount code")
                
                
//                Text("Thanks for your awesome review!")
                Divider()
                    .padding(.bottom)
                
//                Text("Know any friends who haven't shopped with Athleisure before?")
//                    .padding(.bottom)
                
                Text("Give a friend 20% off, and earn 20K points when they make their purchase!")
                    .foregroundColor(Color("Dark1"))
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            }

            Spacer()
        
        
            Button(action: {
                isShowingReferExperience = true
            }) {
               HStack {
                   Spacer()
                   Text("Refer a friend!")
                       .foregroundColor(Color.white)
                       .font(.system(size: 18))
                       .fontWeight(.semibold)
                       .padding(.vertical, 16)
                   Spacer()
               }.background(RoundedRectangle(cornerRadius: 36).fill(Color("ReferPurple")))
                .padding(.horizontal)
                .padding(.horizontal)
            }
                .padding(.bottom)
                .padding(.bottom)
            
            
            
        }.background(Color("Background"))
        .ignoresSafeArea(.container, edges: [.horizontal, .bottom])
        .navigationBarTitle("", displayMode: .inline)
        .fullScreenCover(isPresented: $isShowingReferExperience, content: {
            ReferProductCarousel(isShowingReferExperience: $isShowingReferExperience, item: itemObject)
        })
//       .onAppear {
//           self.itemsViewModel.getSnapshotOfItem(itemID: itemObject.itemID)
//       }
        
    }
}


//struct IntentToRefer_Previews: PreviewProvider {
//    static var previews: some View {
//        IntentToRefer()
//    }
//}
