//
//  AddCompanyPreview.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 7/19/22.
//

import SwiftUI

struct AddCompanyPreview: View {
    var body: some View {
        VStack {
            NavigationLink(destination: AddCompany()) {
                AddCompanyWidget()
            }
            NavigationLink(destination: AddCompany()) {
                AddCompanyWidget()
            }
            
        }
    }
}

struct AddCompanyPreview_Previews: PreviewProvider {
    static var previews: some View {
        AddCompanyPreview()
    }
}
