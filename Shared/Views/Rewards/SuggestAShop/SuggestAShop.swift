//
//  SuggestAShop.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/2/22.
//

import SwiftUI

struct SuggestAShop: View {
    
    @Binding var isSuggestAShopActive:Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("Background")
            VStack {
                VStack(alignment: .leading) {
                    //Header
                    HStack (alignment: .center) {
                        Text("Your account")
                            .font(.system(size: 24))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Dark1"))
                        Spacer()
                        Button {
                            isSuggestAShopActive.toggle()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(Color("Dark1"))
                                .font(Font.system(size: 20, weight: .semibold))
                        }
                    }.padding(.top, 48)
                    .padding()
                }
                Spacer()
                VStack {
                    Text("we want to add every company to the Uncommon app")
                    Text("we're starting out by building loyalty programs for companies that don't have one")
                    Text("Do you have a suggestion?")
                    Text("1. We want to find more companies to add to the network")
                    Text("1. START")
                    Text("2. What's the name of the company?")
                    Text("3. What's their website link?")
                    Text("4. Why would you want them? (We might send your reasoning to this company to convince them to join")
                    Text("5. Thank you!")
                }
                Spacer()
            }
        }.ignoresSafeArea()
    }
}

struct SuggestAShop_Previews: PreviewProvider {
    static var previews: some View {
        SuggestAShop(isSuggestAShopActive: .constant(true))
    }
}
