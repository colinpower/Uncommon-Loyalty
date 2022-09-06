//
//  AddCompanyWidget.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 7/19/22.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseStorage


struct AddCompanyWidget: View {
    
    @State var backgroundURL = ""
    @State var iconURL = ""
    
    
    var companyID: String
    var companyName: String
    var joiningBonus: Int
    var color: Color
    var website: String
    
    
    var body: some View {
        ZStack(alignment: .center) {
            
            if backgroundURL != "" {
                WebImage(url: URL(string: backgroundURL)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(30)
                    .frame(height: 250)
            } else {
                Image("FeaturedAthleisure")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(30)
                    .frame(height: 250)
            }
            
            
            VStack {
                Spacer()
                HStack {
                    
                    if iconURL != "" {
                        WebImage(url: URL(string: iconURL)!)
                            .resizable()
                            .frame(width: 32, height: 32)
                            .cornerRadius(32)
                    } else {
                        Image("Diamond")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .cornerRadius(32)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(companyName)
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Dark1"))
                        Text(String(joiningBonus))
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Dark1"))
                    }
                    
                    Spacer()
                    
                    
//                    {
                        Text("Join")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Dark1"))
                            .padding(.vertical, 6)
                            .padding(.horizontal, 16)
                            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(color))
//                    }
                    
                    
//                    NavigationLink {
//                        AddCompany(isAddCompanyActive: $isAddCompanyActive, isAddCompanyPreviewActive: $isAddCompanyPreviewActive, companyID: companyID, companyName: companyName, joiningBonus: joiningBonus, website: website)
//                    } label: {
//                        Text("Join")
//                            .font(.system(size: 16))
//                            .fontWeight(.semibold)
//                            .foregroundColor(Color("Dark1"))
//                            .padding(.vertical, 6)
//                            .padding(.horizontal, 16)
//                            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(color))
//                    }

                }.padding().background(.ultraThinMaterial, in: Rectangle())
            }.frame(height: 250)
        }
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .padding(.horizontal)
        .padding(.bottom)
        
        .onAppear {
            let backgroundPath = "companies/" + companyID + "/background.png"
            let iconPath = "companies/" + companyID + "/icon.png"
            
            let storage = Storage.storage().reference()
            
            storage.child(backgroundPath).downloadURL { url, err in
                if err != nil {
                    print(err?.localizedDescription ?? "Issue showing the right image")
                    return
                } else {
                    self.backgroundURL = "\(url!)"
                }
            }
            
            storage.child(iconPath).downloadURL { url, err in
                if err != nil {
                    print(err?.localizedDescription ?? "Issue showing the right image")
                    return
                } else {
                    self.iconURL = "\(url!)"
                }
            }
            
        }
    }
}

//struct AddCompanyWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCompanyWidget()
//    }
//}
