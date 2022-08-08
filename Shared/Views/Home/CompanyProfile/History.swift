//
//  History.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/8/22.
//

import SwiftUI

struct History: View {
    
    
    var companyID: String
    var email: String
    
    
    @Binding var isHistoryActive:Bool
    
    @ObservedObject var viewModel3 = TransactionsViewModel()
    
    var body: some View {
        GeometryReader { geometry in
                        
            ZStack(alignment: .top) {
                
                //MARK: Background color
                Color("Background")
                
                //the content on top of the background
                VStack(alignment: .leading) {
                    
                    //MARK: Header
                    SheetHeader(title: "Your History", isActive: $isHistoryActive)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        //MARK: Activity (Purchases, Spent Points, Reviews, Referrals)
                        VStack(alignment: .leading) {
                            
                            //FOR EACH DISCOUNT CODE, SHOW IT HERE
                            ForEach(viewModel3.myTransactions.prefix(15)) { DiscountCode in
                                MyHistoryItem(type: DiscountCode.type, timestamp: DiscountCode.timestamp, pointsEarnedOrSpent: DiscountCode.pointsEarnedOrSpent, colorToShow: Color("ThemePrimary"))
                            }
                            HStack {
                                Spacer()
                                Text("More")
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("ThemePrimary"))
                                Spacer()
                            }
                        }.padding()
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
                        .padding(.horizontal)
                        .padding(.bottom)
                            
                        }
                    }
            }
        }.ignoresSafeArea()
        .onAppear {
            self.viewModel3.listenForMyTransactions(email: "colinjpower1@gmail.com", companyID: companyID)
        }
    }
}

struct History_Previews: PreviewProvider {
    static var previews: some View {
        History(companyID: "zKL7SQ0jRP8351a0NnHM", email: "colinjpower1@gmail.com", isHistoryActive: .constant(true))
    }
}
