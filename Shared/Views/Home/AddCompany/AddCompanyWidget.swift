//
//  AddCompanyWidget.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 7/19/22.
//

import SwiftUI

struct AddCompanyWidget: View {
    
    var backgroundImage: String
    var companyLogo: String
    var company: String
    var joiningBonus: String
    var color: Color
    
    var body: some View {
        ZStack(alignment: .center) {
            Image(backgroundImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(30)
                .frame(height: 250)
            VStack {
                Spacer()
                HStack {
                    Image(companyLogo)
                        .resizable()
                        .frame(width: 32, height: 32)
                        .cornerRadius(32)
                    VStack(alignment: .leading) {
                        Text(company)
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Dark1"))
                        Text(joiningBonus)
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Dark1"))
                    }
                    
                    Spacer()
                    NavigationLink {
                        AddCompany(companyIcon: companyLogo, company: company, backgroundImage: backgroundImage, joiningBonus: joiningBonus)
                    } label: {
                        Text("Join")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Dark1"))
                            .padding(.vertical, 6)
                            .padding(.horizontal, 16)
                            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(color))
                    }

                }.padding().background(.ultraThinMaterial, in: Rectangle())
            }.frame(height: 250)
        }
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .padding(.horizontal)
        .padding(.bottom)
    }
}

//struct AddCompanyWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCompanyWidget()
//    }
//}
