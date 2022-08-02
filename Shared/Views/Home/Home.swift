//
//  Home.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 1/17/22.
//

import SwiftUI
import FirebaseAuth

struct Home: View {
    
    //@State var showingDiscountScreen: Bool = false
    @ObservedObject var viewModel1 = RewardsProgramViewModel()
    
    @State var isAddCompanyPreviewActive:Bool = false
    @State var isTestPreviewShown:Bool = false
    
    @State var isProfileActive:Bool = false
    @State var isAddProgramActive:Bool = false
    
    @State var x : [CGFloat] = [0, 0, 0, 0, 0, 0]
    @State var colorbg : [Color] = [Color.red, Color.orange, Color.yellow, Color.green, Color.blue, Color.purple]
    @State var endOfCards = false
    
    //@Binding var selectedTab: Int
    
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                ZStack(alignment: .top) {
                    //Background color
                    Color(red: 244/255, green: 244/255, blue: 244/255)
                    
                    //Actual content of this page
                    VStack(alignment: .leading) {
                        //Header
                        HStack{
                            Text("Loyalty Programs")
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Dark1"))
                            Spacer()
                            Button {
                                isProfileActive.toggle()
                            } label: {
                                Image(systemName: "person.crop.circle")
                                    .foregroundColor(Color("Dark1"))
                                    .font(.system(size: 30))
                            }.fullScreenCover(isPresented: $isProfileActive, content: {
                                Profile(isProfileActive: $isProfileActive)
                            })
                        }.padding(.top, 48)
                        .padding()
                        .background(Color(red: 244/255, green: 244/255, blue: 244/255))
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            //My programs section
                            VStack(alignment: .leading) {
                                //Title
                                HStack {
                                    Text("Your Programs")
                                        .font(.system(size: 20))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("Dark1"))
                                    Spacer()
                                    Button {
                                        isAddCompanyPreviewActive.toggle()
                                    } label: {
                                        Text("Add")
                                            .font(.system(size: 16))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("Dark1"))
                                            .padding(.vertical, 6)
                                            .padding(.horizontal, 16)
                                            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(Color(red: 244/255, green: 244/255, blue: 244/255)))
                                    }.sheet(isPresented: $isAddCompanyPreviewActive, content: {
                                        AddCompanyPreview(isAddCompanyPreviewActive: $isAddCompanyPreviewActive)
                                    })
                                }.padding(.top)
                                    .padding(.horizontal)
                                
                                //Body
                                VStack {
                                    //FOR EACH LOYALTY PROGRAM, SHOW IT HERE
                                    ForEach(viewModel1.myRewardsPrograms) { RewardsProgram in

                                        NavigationLink(destination: CompanyProfileV2(companyID: RewardsProgram.companyID, companyName: RewardsProgram.companyName, email: RewardsProgram.email, userID: RewardsProgram.userID)) {
                                                RewardsProgramWidget(companyName: RewardsProgram.companyName, image: RewardsProgram.companyName, currentPointsBalance: RewardsProgram.currentPointsBalance, status: RewardsProgram.status)
                                        }
                                    }
                                }.padding()

                                //Footer
                                HStack() {
                                    Spacer()
                                    Button {
                                        isProfileActive.toggle()
                                    } label: {
                                        Text("See all")
                                            .font(.system(size: 16))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color.blue)
                                    }.sheet(isPresented: $isProfileActive, content: {
                                        Profile(isProfileActive: $isProfileActive)
                                    })
                                    Spacer()
                                }.padding()

                            }
                            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
                            .padding()

                            //New content (horizontal scrollview
                            ScrollView (.horizontal, showsIndicators: false) {
                                HStack{
                                    RoundedRectangle(cornerRadius: 16)
                                        .foregroundColor(Color("Gray3"))
                                        .frame(width: geometry.size.width/3*2, height: 120)
                                    RoundedRectangle(cornerRadius: 16)
                                        .foregroundColor(Color("Gray3"))
                                        .frame(width: geometry.size.width/3*2, height: 120)
                                    RoundedRectangle(cornerRadius: 16)
                                        .foregroundColor(Color("Gray3"))
                                        .frame(width: geometry.size.width/3*2, height: 120)
                                }.padding(.horizontal)
                                    .padding(.bottom)
                            }
                            
                            
                            //MAKE US BETTER
                            HStack {
                                Text("MAKE US BETTER").kerning(1.2)
                                    .font(.system(size: 13))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("Gray1"))
                                Spacer()
                            }.padding(.horizontal)
                                .padding(.top)
                            VStack{
                                //Suggest new store
                                HStack {
                                    Image(systemName: "building.2.crop.circle.fill")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 40))
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("Suggest a store")
                                            .font(.system(size: 16))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("Dark1"))
                                        Text("Which stores should we add next?")
                                            .font(.system(size: 16))
                                            .fontWeight(.regular)
                                            .foregroundColor(Color("Gray2"))
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color("Gray3"))
                                        .font(Font.system(size: 15, weight: .semibold))
                                }.padding(.bottom)
                                //Send feedback
                                HStack {
                                    Image(systemName: "bubble.left.circle.fill")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 40))
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("Send feedback")
                                            .font(.system(size: 16))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("Dark1"))
                                        Text("We respond super fast!")
                                            .font(.system(size: 16))
                                            .fontWeight(.regular)
                                            .foregroundColor(Color("Gray2"))
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color("Gray3"))
                                        .font(Font.system(size: 15, weight: .semibold))
                                }
                                    
                            }.padding(.horizontal, 12)
                            .padding(.vertical)
                            .background(.white)
                            .padding(.bottom)
                            
                        }
                    }
                }
            }
            .ignoresSafeArea()
            .navigationTitle("")
            .navigationBarHidden(true)
            .onAppear(perform: {
                    self.viewModel1.listenForMyRewardsPrograms(email: Auth.auth().currentUser?.email ?? "")
                    print("CURRENT USER IS")
                    print(Auth.auth().currentUser?.email ?? "")
                    print(self.viewModel1.myRewardsPrograms)
                })
            .onDisappear {
                    print("DISAPPEAR")
                    if self.viewModel1.listener1 != nil {
                        print("REMOVING LISTENER")
                        self.viewModel1.listener1.remove()
                    }
                }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}





//MARK: Unused code

//This was for showing a quick link to the rewards page
//                    NavigationLink(destination: ReviewProductPreview(companyID: "zKL7SQ0jRP8351a0NnHM", email: "colinjpower1@gmail.com", orderID: "", userID: "mhjEZCv9JGdk0NUZaHMcNrDsH1x2")) {
//                        Image(systemName: "plus.circle.fill")
//                            .font(.system(size: 30))
//                        }



//This was for swiping cards at the top
//ScrollView(.horizontal) {
//if x.count == 0 || endOfCards {
//    EmptyView()
//} else {
//    ZStack {
//        ForEach(0..<x.count, id: \.self) { i in
//            ReviewOrReferWidget(colorbg: colorbg[i])
//                .frame(width: geometry.size.width, height: geometry.size.height * 0.2, alignment: .center)
//                .offset(x: self.x[i])
//                .gesture(DragGesture()
//                    .onChanged({ value in
//                        if value.translation.width > 0 {
//                            self.x[i] = value.translation.width
//                        } else {
//                            self.x[i] = value.translation.width
//                        }
//
//
//                    })
//                    .onEnded({ value in
//                        if value.translation.width > 0 {
//                            if value.translation.width > 100 {
//                                self.x[i] = geometry.size.width
//                                if i == 0 {
//                                    withAnimation {
//                                        endOfCards = true
//                                    }
//
//                                }
//                            } else {
//                                self.x[i] = 0
//                            }
//                        } else {
//                            if value.translation.width < -100 {
//                                self.x[i] = -geometry.size.width
//                                if i == 0 {
//                                    withAnimation {
//                                        endOfCards = true
//                                    }
//                                }
//                            } else {
//                                self.x[i] = 0
//                            }
//                        }
//                    }))
//        }
//    }
//}
