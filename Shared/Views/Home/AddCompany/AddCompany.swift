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
            Color("Background")
            
            ScrollView(.vertical) {
                VStack (alignment: .leading) {
                    Image(companyIcon!)
                        .resizable()
                        .frame(width: 60, height: 60)
                    Text(company!)
                        .font(.system(size: 32))
                        .fontWeight(.semibold)
                        .padding(.bottom)
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
                    
                    //MARK: Quick actions
                    VStack(alignment: .leading, spacing: 0) {
                        
                        //Title
                        HStack {
                            Text("Details")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Dark1"))
                            Spacer()
                        }
                        
                        Text("Join the XXXX loyalty program today.")
                            .font(.system(size: 16))
                            .fontWeight(.regular)
                            .foregroundColor(Color("Gray1"))
                            .multilineTextAlignment(.leading)
                            .lineSpacing(8)
                            .padding(.vertical, 16)
                        
                        //Body
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Link to website")
                                Spacer()
                                Link(destination: URL(string: linkToWebsite!)!) {
                                    Text(linkToWebsite!)
                                }
                            }
                            HStack {
                                Text("Initial bonus")
                                Spacer()
                                Text("15% off first purchase")
                            }
                            HStack {
                                Text("Points per dollar")
                                Spacer()
                                Text("15% off first purchase")
                            }
                        }
                    }.padding().background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white)).padding(.horizontal)
                    
                    //MARK: Quick actions
                    VStack(alignment: .leading, spacing: 0) {
                        
                        //Title
                        HStack {
                            Text("About XXXXXX Company")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Dark1"))
                            Spacer()
                        }.padding(.bottom)
                        
                        Text(aboutTheBrand!) + Text("Join the XXXX loyalty program today.").font(.system(size: 16)).fontWeight(.regular).foregroundColor(Color("Gray1"))
                            
                        
                    }.padding().background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white)).padding(.horizontal)
                }.padding(.horizontal)
            }
            
            VStack {
                Spacer()
                VStack(alignment: .center, spacing: 8) {
                    HStack {
                        Rectangle().frame(width: 40, height: 40).padding(.trailing, 6)
                        Text("Share my email with XXXX company")
                    }
                    HStack {
                        Spacer()
                        Text("Join!")
                        Spacer()
                    }.padding()
                    .background(RoundedRectangle(cornerRadius: 30).foregroundColor(Color("ThemePrimary"))).padding(.horizontal)
                }.padding(.bottom).padding(.bottom)
                .background(Rectangle().foregroundColor(Color.white))
            }.ignoresSafeArea()
        }.navigationBarTitleDisplayMode(.inline)
            .navigationTitle("")
    }
}

struct AddCompany_Previews: PreviewProvider {
    static var previews: some View {
        AddCompany()
    }
}
