//
//  AddCompanyPreview.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 7/19/22.
//

import SwiftUI

struct AddCompanyPreview: View {
    
    @Binding var isAddCompanyPreviewActive : Bool
    @State private var companies = ["Company A", "Company B"]
    
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
        AddCompanyPreview(isAddCompanyPreviewActive: .constant(true))
    }
}
