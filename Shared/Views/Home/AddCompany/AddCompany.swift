//
//  AddCompany.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 7/19/22.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseStorage
import FirebaseAuth

struct AddCompany: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    @StateObject var viewModel1 = RewardsProgramViewModel()

    
    @State var backgroundURL = ""
    @State var iconURL = ""
    
    @State private var wasLoyaltyProgramJoined:Bool = false
    @State private var hasEmailPermissionBeenGranted: Bool = false
    
    
    var companyID: String = "NULL"
    var companyName: String = "Athleisure LA"
    var popularItem1: String? = "Athleisure LA"
    var popularItem2: String? = "Athleisure LA"
    var popularItem3: String? = "Athleisure LA"
    var aboutTheBrand: String? = "This is a little snippet about the brand that goes here"
    var joiningBonus: Int? = 15
    var website: String? = "www.google.com"
    
    
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("Background")
            
            ScrollView(.vertical) {
                VStack (alignment: .leading) {
                    
                    if iconURL != "" {
                        WebImage(url: URL(string: iconURL)!)
                            .resizable()
                            .frame(width: 60, height: 60)
                            .cornerRadius(30)
                    } else {
                        Image("Diamond")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .cornerRadius(30)
                    }
                    
                
                    Text(companyName)
                        .font(.system(size: 32))
                        .fontWeight(.semibold)
                        .padding(.bottom)
                    
                    
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
                    
                    
                    
//                    Image(backgroundImage!)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .cornerRadius(30)
//                        .frame(height: 250)
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
                                Link(destination: URL(string: website!)!) {
                                    Text(website!)
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
                        if hasEmailPermissionBeenGranted {
                            Image(systemName: "checkmark.square.fill")
                                .foregroundColor(Color("ThemePrimary"))
                                .frame(width: 40, height: 40).padding(.trailing, 6)
                        } else {
                            Image(systemName: "square")
                                .frame(width: 40, height: 40).padding(.trailing, 6)
                                .onTapGesture {
                                    hasEmailPermissionBeenGranted = true
                                }
                        }
                        Text("Share my email with XXXX company")
                    }
                    
                    if wasLoyaltyProgramJoined {
                        HStack {
                            Spacer()
                            Text("Joined!")
                            Spacer()
                        }.padding()
                            .background(RoundedRectangle(cornerRadius: 30).foregroundColor(Color.blue)).padding(.horizontal)
                    } else {
                        Button {
                            self.viewModel1.addLoyaltyProgram(companyID: companyID, companyName: companyName, currentPointsBalance: 0, email: viewModel.email ?? "", lifetimePoints: 0, referralCode: "", status: "", userID: viewModel.userID ?? "")
                            wasLoyaltyProgramJoined.toggle()
                        } label: {
                            HStack {
                                Spacer()
                                Text("Join!")
                                Spacer()
                            }.padding()
                            .background(RoundedRectangle(cornerRadius: 30).foregroundColor(Color("ThemePrimary"))).padding(.horizontal)
                        }.disabled(!hasEmailPermissionBeenGranted)
                    }
                
                }.padding(.bottom).padding(.bottom)
                .background(Rectangle().foregroundColor(Color.white))
            }.ignoresSafeArea()
        }.navigationBarTitleDisplayMode(.inline)
            .navigationTitle("")
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

//struct AddCompany_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCompany()
//    }
//}
