//
//  CombinedCardForReferral.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/21/22.
//

import SwiftUI

struct CombinedCardForReferral: View {
    
    //Variables for creating the top section
    var recommendedItemImageString: String
    var recommendedItemName: String
    
    //Variables for creating the custom card
    var cardColor:Color
    var textColor:Color
    
    var companyImage:String
    var companyName:String
    
    var discountAmount:String
    var discountCode:String
    
    var recipientFirstName:String
    var recipientLastName:String
    
    
    var body: some View {
        
        ZStack(alignment: .bottom) {

            

                
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width-20, height: UIScreen.main.bounds.width * 12 / 10)
            

            VStack(alignment: .center, spacing: 0) {

                HStack(alignment: .top, spacing: 0) {

                    VStack(alignment: .leading, spacing: 0) {
                        Text("ATHLEISURE LA")
                        Text("TO COLIN")
                        Text("FROM COLIN")
                    }.frame(width: UIScreen.main.bounds.width / 2 - 11, height: UIScreen.main.bounds.width * 3 / 10)

                    Divider()

                    VStack(alignment: .leading, spacing: 0) {
                        Image(recommendedItemImageString)
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4, alignment: .center)
                            .padding(.bottom, 6)
                        Text("TO COLIN")
                        Text("FROM COLIN")

                    }.frame(width: UIScreen.main.bounds.width / 2 - 11, height: UIScreen.main.bounds.width * 3 / 10)



                }
                .frame(width: UIScreen.main.bounds.width-20, height: UIScreen.main.bounds.width * 3 / 10)
                

                Text("Get $20 off your first order at Athleisure LA using promo code COLIN123")
                    .padding(.vertical)

                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(.clear)
                    .frame(width: UIScreen.main.bounds.width-20, height: UIScreen.main.bounds.width * 7 / 10)

            }.padding(.top)
            .frame(width: UIScreen.main.bounds.width-20, height: UIScreen.main.bounds.width * 12 / 10)
            
            
            
            VStack(alignment: .center, spacing: 0) {
                GeometryReader { geometry in
                    
                    ZStack(alignment: .center) {
                        
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(cardColor)
                            .frame(width: geometry.size.width, height: geometry.size.width / 1.6)
                            .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 5)
                        
                        VStack(alignment: .center, spacing: 0) {
                            HStack(alignment: .center, spacing: 0) {
                                VStack(alignment: .center, spacing: 0) {
                                    //Image(companyImage)
                                    Image(companyImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 30, alignment: .leading)
                                        .padding(.bottom, 2)
                                    Text(companyName)
                                        .font(.system(size: 12))
                                        .fontWeight(.medium)
                                        .font(.system(size: 14, weight: .medium))
                                        .innerShadow(cardColor, radius: 1, opacity: 0.5, offsetx: 0.9, offsety: 0.9, inlaidColor: textColor)
                                        .fixedSize()
                                }
                                .frame(height: 44)
                                
                                Spacer()
                                
                                Text(discountAmount)
                                    .font(.system(size: 44, weight: .bold, design: .rounded))
                                    .innerShadow(cardColor, radius: 1.5, opacity: 0.5, offsetx: 1, offsety: 1, inlaidColor: textColor)
                                    .fixedSize()
                            }.padding([.top, .horizontal])
                            
                            Spacer()
                            
                            VStack(alignment: .center, spacing: 0) {
                                
                                Text(discountCode)
                                    .font(.system(size: 44, weight: .bold))
                                    .innerShadow(cardColor, radius: 1.5, opacity: 0.5, offsetx: 1, offsety: 1, inlaidColor: textColor)
                                    .fixedSize()
                                //.foregroundColor(textColor)
                                Text("\(recipientFirstName.uppercased())'S DISCOUNT CODE")
                                    .font(.system(size: 14, weight: .medium))
                                    .innerShadow(cardColor, radius: 1, opacity: 0.5, offsetx: 0.9, offsety: 0.9, inlaidColor: textColor)
                                    .fixedSize()
                                
                                
                            }.frame(width: geometry.size.width, height: 70, alignment: .center)
                            
                            Spacer()
                            
                            HStack(alignment: .bottom, spacing: 0) {
                                
                                VStack(alignment: .leading, spacing: 0) {
                                    Text(recipientFirstName + recipientLastName)
                                        .font(.system(size: 20, weight: .medium))
                                        .innerShadow(cardColor, radius: 1.2, opacity: 0.5, offsetx: 1, offsety: 1, inlaidColor: textColor)
                                        .fixedSize()
                                    
                                    
                                }.frame(height: 38)
                                
                                Spacer()
                            }
                            .frame(height: 38)
                            .padding([.bottom, .horizontal])
                            
                        }
                        
                    }
                }.padding()
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.6)
                .padding(.bottom, 8)
                .padding(.horizontal, 5)
            
        }.frame(width: UIScreen.main.bounds.width-20, height: UIScreen.main.bounds.width * 12 / 10)
            
            
    }
}

private extension Text {
    
    func innerShadow<V: View>(_ background: V, radius: CGFloat = 1, opacity: Double = 0.5, offsetx: Double, offsety: Double, inlaidColor: Color) -> some View {
        
        self
            .foregroundColor(.clear)
            .overlay(background.mask(self))
            .overlay(
                ZStack {
//                    self.foregroundColor(Color(white: 1 - opacity))
                    self.foregroundColor(Color(white: 1 - opacity))
                    //self.foregroundColor(Color("GoldInlaidText")).blur(radius: 3).offset(x:1.5,y:1.5)
                    self.foregroundColor(inlaidColor).blur(radius: radius).offset(x:offsetx, y:offsety)
                    
//                    self.foregroundColor(Color("GoldShadow").opacity(0.5))
//                    self.foregroundColor(Color("GoldShadow")).blur(radius: 2) //.offset(x:0.3,y:0.3)
                }
                    .mask(self)
                    .blendMode(.multiply)
            )
    }
}

