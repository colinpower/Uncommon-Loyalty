//
//  AddCompany.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 7/19/22.
//

import SwiftUI

struct AddCompany: View {
    
    var companyIcon: String? = "Athleisure LA"
    var company: String? = "Athleisure LA"
    var backgroundImage: String? = "Skincare Background"
    var popularItem1: String? = "Athleisure LA"
    var popularItem2: String? = "Athleisure LA"
    var popularItem3: String? = "Athleisure LA"
    var aboutTheBrand: String? = "This is a little snippet about the brand that goes here"
    var linkToWebsite: String? = "www.google.com"
    var joiningBonus: String? = "15% off first purchase"
    
    @State var userSubmittedEmail: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(.vertical) {
                VStack (alignment: .leading) {
                    Image(companyIcon!)
                        .resizable()
                        .frame(width: 48, height: 48)
                    Text(company!)
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                    Image(backgroundImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(30)
                        .frame(height: 250)
//                    Text("Most Popular")
//                        .font(.system(size: 24))
//                        .fontWeight(.semibold)
//                    HStack {
//                        Image(popularItem1!)
//                            .resizable()
//                            .frame(width: 60, height: 60)
//                        Image(popularItem2!)
//                            .resizable()
//                            .frame(width: 60, height: 60)
//                        Image(popularItem3!)
//                            .resizable()
//                            .frame(width: 60, height: 60)
//                    }
                    
                    Text("About the company")
                    Text(aboutTheBrand!) + Text("alsdkfjasd").fontWeight(.semibold) + Text("alsdkfjasd").fontWeight(.regular)
                }.padding(.horizontal)
            }
            VStack {
                Spacer()
                HStack {
                    Text("Link to website")
                    Link(destination: URL(string: linkToWebsite!)!) {
                        Text(linkToWebsite!)
                    }
                }
                Text(joiningBonus!)
                Text("JOIN NOW BUTTON")
                    .padding()
                    .background(.red)
            }
        }.navigationBarTitleDisplayMode(.inline)
            .navigationTitle("")
    }
}

struct AddCompany_Previews: PreviewProvider {
    static var previews: some View {
        AddCompany()
    }
}
