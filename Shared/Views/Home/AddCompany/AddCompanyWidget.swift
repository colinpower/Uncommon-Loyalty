//
//  AddCompanyWidget.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 7/19/22.
//

import SwiftUI

struct AddCompanyWidget: View {
    var body: some View {
        HStack {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 30))
            Text("Company example 1")
        }.padding(.vertical, 30)
    }
}

struct AddCompanyWidget_Previews: PreviewProvider {
    static var previews: some View {
        AddCompanyWidget()
    }
}
