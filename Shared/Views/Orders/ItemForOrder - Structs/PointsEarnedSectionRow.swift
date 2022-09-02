//
//  PointsEarnedSectionRow.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/2/22.
//

import SwiftUI

struct PointsEarnedSectionRow: View {
    
    var image:String
    var imageColor:Color
    var title:String
    var points:String
    var isEnabled:Bool
    
    
    var body: some View {
        
        HStack {
            Image(systemName: image)
                .font(.system(size: 28))
                .foregroundColor(isEnabled ? imageColor : .gray)
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(isEnabled ? .black : .gray)
            Spacer()
            Text(points)
                .font(.system(size: 16))
                .foregroundColor(isEnabled ? .black : .gray)
        }
    }
}

//struct PointsEarnedSectionRow_Previews: PreviewProvider {
//    static var previews: some View {
//        PointsEarnedSectionRow()
//    }
//}
