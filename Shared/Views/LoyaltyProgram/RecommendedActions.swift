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
                HStack {
                    Spacer()
                    VStack {
                        Text(item.itemID)
                        Text(item.price)
                        Text(item.orderID)
                    }.padding(.vertical, 20)
                    Spacer()
                }.background(.red)
            }
            
        }//.frame(height: UIScreen.main.bounds.height/2)
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
            
    }
}

//struct RecommendedActions_Previews: PreviewProvider {
//    static var previews: some View {
//        RecommendedActions()
//    }
//}
