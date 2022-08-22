//
//  Order_Item.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/22/22.
//

import SwiftUI

struct ItemForOrder: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    
    //Required variables to be passed
    var userID: String
    var email: String
    var companyID: String
    var itemID: String
    
    
    //Setup variables for Review / Referral
    @State var isShowingReviewScreen:Bool = false
    @State var isShowingReferScreen:Bool = false
    
    //use this variable to be passed back when the user submits a review but you don't know yet??
    @State var finishedReviewLocalLie:Bool = false
    
    //Listeners
    @StateObject var itemsViewModel = ItemsViewModel()
    
    
    var body: some View {
        ZStack {
            Color("Background")
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    
                    ForEach(itemsViewModel.snapshotOfItem.prefix(1)) { item in
                        VStack (alignment: .center) {
                            
                            //Large image of item
                            Image(systemName: "circle.fill")
                                .font(.system(size: 48))
                            
                            //Prompt to write a review
                            HStack {
                                Spacer()
                                //Link to create a review
                                Button {
                                    isShowingReviewScreen = true
                                } label: {
                                    Text("show Review screen")
                                }.fullScreenCover(isPresented: $isShowingReviewScreen) {
                                    ReviewProductCarousel1(showingReviewProductScreen: $isShowingReviewScreen, companyID: companyID, itemID: itemID, email: email, emailUID: viewModel.userID ?? "")
                                }
                                Spacer()
                            }
                            .padding(.vertical)
                            .background(RoundedRectangle(cornerRadius: 24).foregroundColor(.white))
                            .padding()
                            
                            //Prompt to refer
                            HStack {
                                Spacer()
                                //Link to refer a friend
                                Button {
                                    isShowingReferScreen = true
                                } label: {
                                    Text("show Refer screen")
                                }.fullScreenCover(isPresented: $isShowingReferScreen) {
                                    ReferAFriend(companyID: companyID, companyName: "Athleisure LA TEST", isReferCompanyActive: $isShowingReferScreen)
                                }
                                Spacer()
                            }
                            .padding(.vertical)
                            .background(RoundedRectangle(cornerRadius: 24).foregroundColor(.white))
                            .padding()
                            
                            //Details of the item
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(item.title)
                                    Spacer()
                                }.padding(.bottom)
                                
                                HStack {
                                    Text("Price")
                                    Spacer()
                                    Text(item.price)
                                }.padding(.bottom)
                                
                                HStack {
                                    Text("Date")
                                    Spacer()
                                    Text(String(item.timestamp))
                                }.padding(.bottom)
                                
                                HStack {
                                    Text("Review")
                                    Spacer()
                                    Text(String(item.reviewRating))
                                }
                                    
                                HStack {
                                    Text("Order Number")
                                    Spacer()
                                    Text(item.orderID)
                                }.padding(.bottom)
                                        
                                HStack {
                                    Text("Ordered on")
                                    Spacer()
                                    Text("Aug 06")
                                }.padding(.bottom)
                                
                                HStack {
                                    Text("Days to return")
                                    Spacer()
                                    Text("4 days")
                                }
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 24).foregroundColor(.white))
                            .padding()
                    
                    
                            WideWidgetHeader(title: "MORE INFORMATION")
                                .padding(.top)
                            VStack {
                                
                                //Item 1: Email
                                WideWidgetItem(image: "envelope.fill", size: 20, color: Color("Dark1"), title: "Contact").padding(.bottom).padding(.bottom)
                                
                                //Item 2: Email
                                WideWidgetItem(image: "envelope.fill", size: 20, color: Color("Dark1"), title: "Return Policy").padding(.bottom).padding(.bottom)
                                
                                //Item 3: Email
                                WideWidgetItem(image: "envelope.fill", size: 20, color: Color("Dark1"), title: "About Us").padding(.bottom).padding(.bottom)
                            }
                            .padding(.bottom)
                            .background(Color(.white))
                    
                        }
                    }
                }
            }
        }
        .navigationBarTitle(itemsViewModel.snapshotOfItem.first?.itemID ?? "Item", displayMode: .inline)
        .onAppear {
            self.itemsViewModel.getSnapshotOfItem(itemID: itemID)
        }
    }
}

struct ItemForOrder_Previews: PreviewProvider {
    static var previews: some View {
        ItemForOrder(userID: "mhjEZCv9JGdk0NUZaHMcNrDsH1x2", email: "colinjpower1@gmail.com", companyID: "zKL7SQ0jRP8351a0NnHM", itemID: "Z3GBvz1xRYuHl8Tj6Z9j")
    }
}





