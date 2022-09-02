//
//  OrderSectionRow.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/2/22.
//

import SwiftUI

struct OrderSectionRow: View {
    
    var title:String
    var description:String
    
    var body: some View {
        
        HStack {
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.black)
            Spacer()
            Text(description)
                .font(.system(size: 16))
                .foregroundColor(.black)
        }
    }
}

//struct OrderSectionRow_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderSectionRow()
//    }
//}
