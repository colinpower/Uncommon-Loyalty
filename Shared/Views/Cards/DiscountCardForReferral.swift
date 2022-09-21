//
//  CombinedCardForReferral.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/21/22.
//

import SwiftUI

struct DiscountCardForReferral: View {
    
    
    //Variables for creating the custom card
    var designSelection: [Any]
    
    var companyImage:String
    var companyName:String
    
    var discountAmount:String
    var discountCode:String
    
    var recipientFirstName:String
    var recipientLastName:String
    
    
    var body: some View {
        
        let cardColor:Color = designSelection[0] as! Color
        let textColor:Color = designSelection[1] as! Color
        let cardType: String = designSelection[2] as! String
        let coloredCompanyImage: String = designSelection[3] as! String
        
        let coloredCompanyImageWithPrefix:String = "AthleisureLA-Icon-" + coloredCompanyImage
        
        

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
                                    Image(coloredCompanyImageWithPrefix)
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
                                Text(recipientFirstName == "First" ? "YOUR FRIEND'S DISCOUNT CODE" : "\(recipientFirstName.uppercased())'S DISCOUNT CODE")
                                    .font(.system(size: 14, weight: .medium))
                                    .innerShadow(cardColor, radius: 1, opacity: 0.5, offsetx: 0.9, offsety: 0.9, inlaidColor: textColor)
                                    .fixedSize()
                                
                            }.frame(width: geometry.size.width, height: 70, alignment: .center)
                            
                            Spacer()
                            
                            HStack(alignment: .bottom, spacing: 0) {
                                
                                VStack(alignment: .leading, spacing: 0) {
                                    Text(recipientFirstName + " " + recipientLastName)
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
            
            
    }
}

struct DiscountCardForReferralImageCreation: View {
    
    //Variables for creating the custom card
    
    var designSelection: [Any]
    
    var companyImage:String
    var companyName:String
    
    var discountAmount:String
    var discountCode:String
    
    var recipientFirstName:String
    var recipientLastName:String
    
    var screenWidth = UIScreen.main.bounds.width
    
    
    var body: some View {
        
        let cardColor:Color = designSelection[0] as! Color
        let textColor:Color = designSelection[1] as! Color
        let cardType: String = designSelection[2] as! String
        let coloredCompanyImage: String = designSelection[3] as! String
        
        let coloredCompanyImageWithPrefix = "AthleisureLA-Icon-" + coloredCompanyImage
        
        //let coloredCompanyImage = 

            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(cardColor)
                .frame(width: screenWidth, height: screenWidth / 1.6)
                .overlay(
                    VStack(alignment: .center, spacing: 0) {
                        HStack(alignment: .center, spacing: 0) {
                            VStack(alignment: .center, spacing: 0) {
                                //Image(companyImage)
                                Image(coloredCompanyImageWithPrefix)
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
                            
                            
                        }.frame(width: screenWidth, height: 70, alignment: .center)
                        
                        Spacer()
                        
                        HStack(alignment: .bottom, spacing: 0) {
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text(recipientFirstName + " " + recipientLastName)
                                    .font(.system(size: 20, weight: .medium))
                                    .innerShadow(cardColor, radius: 1.2, opacity: 0.5, offsetx: 1, offsety: 1, inlaidColor: textColor)
                                    .fixedSize()
                                
                                
                            }.frame(height: 38)
                            
                            Spacer()
                        }
                        .frame(height: 38)
                        .padding([.bottom, .horizontal])
                        
                    }
                
                )
            
            
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
