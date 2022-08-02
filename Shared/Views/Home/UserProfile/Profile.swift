//
//  Profile.swift
//  Uncommon Loyalty
//
//  Created by Colin Power on 4/4/22.
//

import SwiftUI

struct Profile: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @Binding var isProfileActive:Bool
    
    
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                ZStack(alignment: .top) {
                    //Background color
                    Color(red: 244/255, green: 244/255, blue: 244/255)
                    
                    //Actual content of this page
                    VStack(alignment: .leading) {
                        //Header
                        HStack (alignment: .center) {
                            Text("Your account")
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Dark1"))
                            Spacer()
                            Button {
                                isProfileActive.toggle()
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(Color("Dark1"))
                                    .font(Font.system(size: 20, weight: .semibold))
                            }
                        }.padding(.top, 48)
                        .padding()
                        .background(Color(red: 244/255, green: 244/255, blue: 244/255))
                        
                        //Body
                        ScrollView(.vertical, showsIndicators: false) {
                            //My programs section
                            VStack {
                                //Edit Profile section
                                VStack(alignment: .center, spacing: 8) {
                                    
                                    //Profile pic
                                    HStack {
                                        Spacer()
                                        Image(systemName: "person.crop.circle")
                                            .foregroundColor(Color("Dark1"))
                                            .font(.system(size: 80))
                                        Spacer()
                                    }.padding(.top)
                                    Text("Colin Power")
                                        .font(.system(size: 24))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("Dark1"))
                                    Text(verbatim: "colinjpower1@gmail.com")
                                        .font(.system(size: 18))
                                        .fontWeight(.regular)
                                        .foregroundColor(Color("Gray1"))
//                                    Text("(617) 777-2994)")
//                                        .font(.system(size: 18))
//                                        .fontWeight(.regular)
//                                        .foregroundColor(Color("Gray1"))
                                    
//                                    Button {
//                                        //isAddCompanyPreviewActive.toggle()
//                                    } label: {
//                                        HStack {
//                                            Spacer()
//                                            Text("Edit Profile")
//                                                .font(.system(size: 18))
//                                                .fontWeight(.semibold)
//                                                .foregroundColor(Color("Dark1"))
//                                                .padding(.vertical)
//                                            Spacer()
//                                        }
//                                        .background(RoundedRectangle(cornerRadius: 32).foregroundColor(Color(red: 244/255, green: 244/255, blue: 244/255)))
//                                        .padding(.horizontal)
//                                        .padding(.vertical)
//                                    }
    //                                    .sheet(isPresented: $isAddCompanyPreviewActive, content: {
    //                                        AddCompanyPreview(isAddCompanyPreviewActive: $isAddCompanyPreviewActive)
    //                                    })
                                }.padding(.bottom)
                                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
                                    .padding()
                                
                                //Refer a Friend section
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 48))
                                    VStack(alignment: .leading, spacing: 3) {
                                        Text("Invite friends")
                                            .font(.system(size: 16))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("Dark1"))
                                        Text("Get 500 points")
                                            .font(.system(size: 16))
                                            .fontWeight(.regular)
                                            .foregroundColor(Color("Gray2"))
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color("Gray3"))
                                        .font(Font.system(size: 15, weight: .semibold))
                                }.padding(.horizontal, 12)
                                .padding(.vertical)
                                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
                                .padding(.bottom)
                                .padding(.horizontal)


                        
                                //SETTINGS
                                HStack {
                                    Text("SETTINGS").kerning(1.2)
                                        .font(.system(size: 13))
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("Gray1"))
                                    Spacer()
                                }.padding(.horizontal).padding(.top)
                                VStack {
                                    //Name
                                    HStack {
                                        Image(systemName: "person.fill")
                                            .foregroundColor(Color("Dark1"))
                                            .font(.system(size: 20))
                                            .frame(width: 40)
                                        Text("Name")
                                            .font(.system(size: 16))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("Dark1"))
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(Color("Gray3"))
                                            .font(Font.system(size: 15, weight: .semibold))
                                    }.padding(.bottom)
                                        .padding(.bottom)
                                    //Email Address
                                    HStack {
                                        Image(systemName: "envelope.fill")
                                            .foregroundColor(Color("Dark1"))
                                            .font(.system(size: 20))
                                            .frame(width: 40)
                                        Text("Email address")
                                            .font(.system(size: 16))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("Dark1"))
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(Color("Gray3"))
                                            .font(Font.system(size: 15, weight: .semibold))
                                    }.padding(.bottom)
                                        .padding(.bottom)
                                    
                                    //Notifications
                                    HStack {
                                        Image(systemName: "bell.fill")
                                            .foregroundColor(Color("Dark1"))
                                            .font(.system(size: 20))
                                            .frame(width: 40)
                                        Text("Notifications")
                                            .font(.system(size: 16))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("Dark1"))
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(Color("Gray3"))
                                            .font(Font.system(size: 15, weight: .semibold))
                                    }.padding(.bottom)
                                        .padding(.bottom)
                                    
                                    //Help
                                    HStack {
                                        Image(systemName: "questionmark.circle.fill")
                                            .foregroundColor(Color("Dark1"))
                                            .font(.system(size: 20))
                                            .frame(width: 40)
                                        Text("Get help")
                                            .font(.system(size: 16))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("Dark1"))
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(Color("Gray3"))
                                            .font(Font.system(size: 15, weight: .semibold))
                                    }
                                }
                                .padding()
                                .background(.white)
                                .padding(.bottom)
                                
                                // Sign out
                                HStack {
                                    Spacer()
                                    Button {
                                        viewModel.signOut()
                                    } label: {
                                        Text("Sign out")
                                            .font(.system(size: 16))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color(.red))
                                            .padding(.vertical)
                                            .padding(.horizontal, 16)
                                    }
                                    Spacer()
                                }.background(.white)
                                .padding(.bottom, 48)
                            
                        
                            }
                        }
                    }
                }
            }.ignoresSafeArea()
                .navigationTitle("")
                .navigationBarHidden(true)
        }
            
//            .onAppear(perform: {
//                    self.viewModel1.listenForMyRewardsPrograms(email: Auth.auth().currentUser?.email ?? "")
//                    print("CURRENT USER IS")
//                    print(Auth.auth().currentUser?.email ?? "")
//                    print(self.viewModel1.myRewardsPrograms)
//                })
//            .onDisappear {
//                    print("DISAPPEAR")
//                    if self.viewModel1.listener1 != nil {
//                        print("REMOVING LISTENER")
//                        self.viewModel1.listener1.remove()
//                    }
//                }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile(isProfileActive: .constant(true))
    }
}




//
//ScrollView(.vertical, showsIndicators: false) {
//    //My programs section
//    VStack(alignment: .leading) {
//        //Title
//        HStack {
//            Text("My Programs")
//                .font(.system(size: 20))
//                .fontWeight(.semibold)
//                .foregroundColor(Color("Dark1"))
//            Spacer()
//            Button {
//                isAddCompanyPreviewActive.toggle()
//            } label: {
//                Text("Add")
//                    .font(.system(size: 16))
//                    .fontWeight(.semibold)
//                    .foregroundColor(Color("Dark1"))
//                    .padding(.vertical, 6)
//                    .padding(.horizontal, 16)
//                    .background(RoundedRectangle(cornerRadius: 16).foregroundColor(Color(red: 244/255, green: 244/255, blue: 244/255)))
//            }.sheet(isPresented: $isAddCompanyPreviewActive, content: {
//                AddCompanyPreview(isAddCompanyPreviewActive: $isAddCompanyPreviewActive)
//            })
//        }.padding()
//
//        //Body
//        VStack {
//            //FOR EACH LOYALTY PROGRAM, SHOW IT HERE
//            ForEach(viewModel1.myRewardsPrograms) { RewardsProgram in
//
//                NavigationLink(destination: CompanyProfileV2(companyID: RewardsProgram.companyID, companyName: RewardsProgram.companyName, email: RewardsProgram.email, userID: RewardsProgram.userID)) {
//                        RewardsProgramWidget(companyName: RewardsProgram.companyName, image: RewardsProgram.companyName, currentPointsBalance: RewardsProgram.currentPointsBalance, status: RewardsProgram.status)
//                }
//            }
//        }.padding()
//
//        //Footer
//        HStack() {
//            Spacer()
//            Button {
//                isProfileActive.toggle()
//            } label: {
//                Text("See all")
//                    .font(.system(size: 16))
//                    .fontWeight(.semibold)
//                    .foregroundColor(Color.blue)
//            }.sheet(isPresented: $isProfileActive, content: {
//                Profile()
//            })
//            Spacer()
//        }.padding()
//
//    }
//    .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
//    .padding()
//
//    //New content (horizontal scrollview
//    ScrollView (.horizontal, showsIndicators: false) {
//        HStack{
//            RoundedRectangle(cornerRadius: 16)
//                .foregroundColor(Color("Gray3"))
//                .frame(width: geometry.size.width/3*2, height: 120)
//            RoundedRectangle(cornerRadius: 16)
//                .foregroundColor(Color("Gray3"))
//                .frame(width: geometry.size.width/3*2, height: 120)
//            RoundedRectangle(cornerRadius: 16)
//                .foregroundColor(Color("Gray3"))
//                .frame(width: geometry.size.width/3*2, height: 120)
//        }.padding(.horizontal)
//            .padding(.bottom)
//    }
//
//
//    //Help us grow
//    HStack {
//        Text("MAKE US BETTER").kerning(1.2)
//            .font(.system(size: 13))
//            .fontWeight(.medium)
//            .foregroundColor(Color("Gray1"))
//        Spacer()
//    }.padding(.horizontal)
//    VStack{
//        //Suggest new store
//        HStack {
//            Image(systemName: "person.crop.circle")
//                .foregroundColor(.blue)
//                .font(.system(size: 48))
//            VStack(alignment: .leading, spacing: 2) {
//                Text("Suggest a store")
//                    .font(.system(size: 16))
//                    .fontWeight(.semibold)
//                    .foregroundColor(Color("Dark1"))
//                Text("Which stores should we add?")
//                    .font(.system(size: 16))
//                    .fontWeight(.regular)
//                    .foregroundColor(Color("Gray2"))
//            }
//            Spacer()
//            Image(systemName: "chevron.right")
//                .foregroundColor(Color("Gray3"))
//                .font(Font.system(size: 15, weight: .semibold))
//        }.padding(.bottom)
//        //Send feedback
//        HStack {
//            Image(systemName: "person.crop.circle")
//                .foregroundColor(.blue)
//                .font(.system(size: 48))
//            VStack(alignment: .leading, spacing: 2) {
//                Text("Send feedback")
//                    .font(.system(size: 16))
//                    .fontWeight(.semibold)
//                    .foregroundColor(Color("Dark1"))
//                Text("What can we improve?")
//                    .font(.system(size: 16))
//                    .fontWeight(.regular)
//                    .foregroundColor(Color("Gray2"))
//            }
//            Spacer()
//            Image(systemName: "chevron.right")
//                .foregroundColor(Color("Gray3"))
//                .font(Font.system(size: 15, weight: .semibold))
//        }
//
//    }.padding(.horizontal, 12)
//    .padding(.vertical)
//    .background(.white)
//    .padding(.bottom)
//
//}
