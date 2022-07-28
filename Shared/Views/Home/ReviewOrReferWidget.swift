//
//  ReviewOrReferWidget.swift
//  Uncommon Loyalty
//
//  Created by Colin Power on 7/21/22.
//

import SwiftUI

struct ReviewOrReferWidget: View {
    
    var colorbg : Color
    var body: some View {
        HStack {
            Image(systemName: "person.fill")
            VStack {
                Text("Object")
                Text("Company")
                Text("Submit review")
            }
            Spacer()
            Image(systemName: "x.circle")
        }.padding()
            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(colorbg))
            .padding()
        
    }
}

struct ReviewOrReferWidget_Previews: PreviewProvider {
    static var previews: some View {
        ReviewOrReferWidget(colorbg: .green)
    }
}
