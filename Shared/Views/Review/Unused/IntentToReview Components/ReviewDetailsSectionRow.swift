//
//  ReviewDetailsSectionRow.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/2/22.
//

import SwiftUI

struct ReviewDetailsSectionRow: View {
    
    var image:String
    var title:String
    var description:String
    
    var body: some View {
        
        HStack {
            Image(systemName: image)
                .font(.system(size: 20))
                .foregroundColor(Color(.black))
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.black)
            Spacer()
            Text(description)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(Color(.black))
        }
    }
}

//struct ReviewDetailsSectionRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewDetailsSectionRow()
//    }
//}
