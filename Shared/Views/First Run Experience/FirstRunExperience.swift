//
//  FirstRunExperience.swift
//  Uncommon Loyalty
//
//  Created by Colin Power on 8/11/22.
//

import SwiftUI

struct FirstRunExperience: View {
    
//    @AppStorage("hasShownFRE")
//    var hasShownFRE: Bool = false
    
    @State var horizontalOffset : CGFloat = 0
    
    @State private var writing1 = false
    @State private var writing2 = false
    
    @State private var movingCursor1 = false
    @State private var movingCursor2 = false
    
    @State private var blinkingCursor1 = false
    @State private var blinkingCursor2 = false
    
    
    @State private var show1 = false
    @State private var show2 = false
    @State private var show3 = false
    @State private var show4 = false
    @State private var show5 = false
    @State private var show6 = false
    
    @State private var showNext1 = false
    @State private var showFinish = false
    
    @Binding var shouldShowFirstRunExperience:Bool

    let cursorColor = Color(#colorLiteral(red: 0, green: 0.368627451, blue: 1, alpha: 1))

    let emptyChatColor = Color(#colorLiteral(red: 0.2997708321, green: 0.3221338987, blue: 0.3609524071, alpha: 1))
    
    
    //MARK: NEED TO REMEMBER TO TRIGGER hasShownFRE AT THE END!!!!!
    
    
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color("Background")
                
                //MARK: Create the HStack that all this stuff will fit into
                HStack(alignment: .center, spacing: 0) {
                    
                    //MARK: PAGE 1
                    VStack {
                        Spacer()
                        
                        //MARK: Header

                        VStack(alignment: .center) {
                            Text("Welcome to Uncommon!")
                                .foregroundColor(Color("Dark1"))
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .padding(.bottom, 8)
                            ZStack(alignment: .leading) {
                                Text("You are influential. Get rewarded!")
                                    .foregroundColor(Color("Dark1"))
                                    .font(.system(size: 17))
                                    .fontWeight(.medium)
                                    .mask(Rectangle().offset(x: writing1 ? 0 : -270))
                                Rectangle()
                                    .fill(cursorColor)
                                    .opacity(blinkingCursor1 ? 0 : 1)
                                    .frame(width: 2, height: 24)
                                    .offset(x: movingCursor1 ? 268 : 0)
                            }
                        }
    
                        Spacer()
                        
                        //MARK: Section of 3 things
                        VStack(alignment: .leading, spacing: 32) {

                            //MARK: #1
                            HStack(alignment: .center) {
                                Image(systemName: "iphone")
                                    .font(Font.system(size: 36, weight: .regular))
                                    .foregroundColor(Color("ThemeAction"))
                                    .frame(width: 48)
                                VStack(alignment: .leading, spacing: 3) {
                                    Text("Instant access")
                                        .font(.system(size: 16))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("Dark1"))
                                    Text("Just open your phone. No passwords. No spam. No logging in to website widgets.")
                                        .font(.system(size: 14))
                                        .fontWeight(.regular)
                                        .foregroundColor(Color("Gray1"))
                                }
                            }.opacity(show1 ? 1 : 0)
                            
                            //MARK: #2
                            HStack(alignment: .center) {
                                Image(systemName: "dollarsign.circle")
                                    .font(Font.system(size: 36, weight: .regular))
                                    .foregroundColor(Color("ThemeAction"))
                                    .frame(width: 48)
                                VStack(alignment: .leading, spacing: 3) {
                                    Text("Instant usage")
                                        .font(.system(size: 16))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("Dark1"))
                                    Text("Earn and receive your points immediately. Redeem in 3 taps.")                                .font(.system(size: 14))
                                        .fontWeight(.regular)
                                        .foregroundColor(Color("Gray1"))
                                }
                            }.opacity(show2 ? 1 : 0)

                            //MARK: #3
                            HStack(alignment: .center) {
                                Image(systemName: "sun.haze.fill")
                                    .font(Font.system(size: 32, weight: .regular))
                                    .foregroundColor(Color("ThemeAction"))
                                    .frame(width: 48)
                                VStack(alignment: .leading, spacing: 3) {
                                    Text("And much more...")
                                        .font(.system(size: 16))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("Dark1"))
                                    Text("Early access to sales. Vote on future products. Comment in the chats. Discover new brands.")     .font(.system(size: 14))
                                        .fontWeight(.regular)
                                        .foregroundColor(Color("Gray1"))
                                }
                            }.opacity(show3 ? 1 : 0)
                            
                        }.padding(.horizontal).frame(width: geometry.size.width, height: geometry.size.height/2)
                        Spacer()
                        Spacer()
                        
                        //MARK: Continue button
                            Button {
                                withAnimation(.linear(duration: 0.2)) {
                                    horizontalOffset -= geometry.size.width
                                }
                                withAnimation(.easeOut(duration: 3).delay(1).repeatCount(1, autoreverses: false)) {
                                    writing2.toggle()
                                    movingCursor2.toggle()
                                }
                                withAnimation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) {
                                    blinkingCursor2.toggle()
                                }
                                withAnimation(.easeIn(duration: 1).delay(4.5).repeatCount(1)) {
                                    show4.toggle()
                                }
                                withAnimation(.easeIn(duration: 1).delay(5.5).repeatCount(1)) {
                                    show5.toggle()
                                }
                                withAnimation(.easeIn(duration: 1).delay(6.5).repeatCount(1)) {
                                    show6.toggle()
                                }
                                withAnimation(.easeIn(duration: 1).delay(8.5).repeatCount(1)) {
                                    showFinish.toggle()
                                }
                                
                                
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Next")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 16))
                                        .fontWeight(.semibold)
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 16, weight: .semibold))
                                    Spacer()
                                }
                        }
                        .padding(.vertical)
                        .background(RoundedRectangle(cornerRadius: 30).foregroundColor(Color("ThemeSecondary"))).padding(.horizontal)
                        .opacity(showNext1 ? 1 : 0)
                        .padding(.bottom, 80)
                    }
                    .padding(.horizontal)
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                        .offset(x: horizontalOffset)
                
                    
                    
                    //MARK: PAGE 2
                    VStack {
                        Spacer()
                        
                        //MARK: Header
                        
                        VStack(alignment: .center) {
                            Text("How's it work?")
                                .foregroundColor(Color("Dark1"))
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .padding(.bottom, 8)
                            ZStack(alignment: .leading) {
                                Text("Here's the main stuff.........")
                                    .foregroundColor(Color("Dark1"))
                                    .font(.system(size: 17))
                                    .fontWeight(.medium)
                                    .mask(Rectangle().offset(x: writing2 ? 0 : -241))
                                Rectangle()
                                    .fill(cursorColor)
                                    .opacity(blinkingCursor2 ? 0 : 1)
                                    .frame(width: 2, height: 24)
                                    .offset(x: movingCursor2 ? 239 : 0)
                            }
                        }
                        Spacer()
                        
                        //MARK: Section of 3 things
                        VStack(alignment: .leading, spacing: 32) {

                            //MARK: #1
                            HStack(alignment: .center) {
                                Image(systemName: "iphone")
                                    .font(Font.system(size: 36, weight: .regular))
                                    .foregroundColor(Color("ThemeAction"))
                                    .frame(width: 48)
                                VStack(alignment: .leading, spacing: 3) {
                                    Text("The usual rewards")
                                        .font(.system(size: 16))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("Dark1"))
                                    Text("Purchases, birthdays, loyalty tiers, free shipping")
                                        .font(.system(size: 14))
                                        .fontWeight(.regular)
                                        .foregroundColor(Color("Gray1"))
                                        
                                }
                            }.opacity(show4 ? 1 : 0)
                            
                            //MARK: #2
                            HStack(alignment: .center) {
                                Image(systemName: "dollarsign.circle")
                                    .font(Font.system(size: 36, weight: .regular))
                                    .foregroundColor(Color("ThemeAction"))
                                    .frame(width: 48)
                                VStack(alignment: .leading, spacing: 3) {
                                    Text("Lightning-fast reviews & referrals")
                                        .font(.system(size: 16))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("Dark1"))
                                    Text("You'll never enjoy writing a review more.. plus you earn points!")
                                        .font(.system(size: 14))
                                        .fontWeight(.regular)
                                        .foregroundColor(Color("Gray1"))
                                }
                            }.opacity(show5 ? 1 : 0)

                            //MARK: #3
                            HStack(alignment: .center) {
                                Image(systemName: "sun.haze.fill")
                                    .font(Font.system(size: 32, weight: .regular))
                                    .foregroundColor(Color("ThemeAction"))
                                    .frame(width: 48)
                                VStack(alignment: .leading, spacing: 3) {
                                    Text("Redeem for discounts")
                                        .font(.system(size: 16))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("Dark1"))
                                    Text("Less than 10 seconds after you pick up your phone.")
                                        .font(.system(size: 14))
                                        .fontWeight(.regular)
                                        .foregroundColor(Color("Gray1"))
                                }
                            }.opacity(show6 ? 1 : 0)
                            
                        }.padding(.horizontal)
                        
                        Spacer()
                        Spacer()
                        
                        //MARK: Continue button
                            Button {
                                
                                @AppStorage("shouldShowFirstRunExperience") var shouldShowFirstRunExperience:Bool = false
                                shouldShowFirstRunExperience = false
                                
                                //post back to the user's account
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Let's go!")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 16))
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                        }
                        .padding(.vertical)
                        .background(RoundedRectangle(cornerRadius: 30).foregroundColor(Color("ThemeSecondary"))).padding(.horizontal)
                        .opacity(showFinish ? 1 : 0)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                        .offset(x: horizontalOffset)

                }.frame(width: geometry.size.width*2)
                
            }
            .ignoresSafeArea()
            
            .onAppear {
                withAnimation(.easeOut(duration: 3).delay(1).repeatCount(1, autoreverses: false)) {
                    writing1.toggle()
                    movingCursor1.toggle()
                }
                withAnimation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) {
                    blinkingCursor1.toggle()
                }
                withAnimation(.easeIn(duration: 1).delay(4.5).repeatCount(1)) {
                    show1.toggle()
                }
                withAnimation(.easeIn(duration: 1).delay(5.5).repeatCount(1)) {
                    show2.toggle()
                }
                withAnimation(.easeIn(duration: 1).delay(6.5).repeatCount(1)) {
                    show3.toggle()
                }
                withAnimation(.easeIn(duration: 1).delay(8.5).repeatCount(1)) {
                    showNext1.toggle()
                }
            }
            .onDisappear {
                
                @AppStorage("shouldShowFirstRunExperience") var shouldShowFirstRunExperience:Bool = false
                shouldShowFirstRunExperience = false
                
            }
        }
    }
}




//struct FirstRunExperience_Previews: PreviewProvider {
//    static var previews: some View {
//        FirstRunExperience(showFirstRunExperience: .constant(true))
//    }
//}






//    @State private var w1 = 12
//    @State private var w2 = 6
//    @State private var w3 = 6
//
//    @State private var c1 = Color("ThemePrimary")
//    @State private var c2 = Color("Gray2")
//    @State private var c3 = Color("Gray2")
    





//                //MARK: Create the 3 dots indicating progress
//                VStack {
//                    HStack(spacing: 4) {
//                        RoundedRectangle(cornerRadius: 3)
//                            .frame(width: CGFloat(w1), height: 6)
//                            .foregroundColor(c1)
//                        RoundedRectangle(cornerRadius: 3)
//                            .frame(width: CGFloat(w2), height: 6)
//                            .foregroundColor(c2)
//                        RoundedRectangle(cornerRadius: 3)
//                            .frame(width: CGFloat(w3), height: 6)
//                            .foregroundColor(c3)
//
////
////
////                        RoundedRectangle(cornerRadius: 3).frame(width: 18, height: 6, alignment: .center).foregroundColor(Color("ThemePrimary"))
////                        Circle()
////                            .frame(width: 6, height: 6, alignment: .center)
////                            .foregroundColor(Color("Gray2"))
////                        Circle()
////                            .frame(width: 6, height: 6, alignment: .center)
////                            .foregroundColor(Color("Gray2"))
//                    }
//                    Spacer()
//                }.padding(.top, 120)
