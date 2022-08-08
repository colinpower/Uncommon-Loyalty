//
//  Components.swift
//  Uncommon Loyalty
//
//  Created by Colin Power on 8/4/22.
//

import SwiftUI
import Foundation

struct SheetHeader: View {
    
    var title: String
    var color:Color? = Color("Dark1")
    
    @Binding var isActive: Bool

    
    var body: some View {
        HStack (alignment: .center) {
            Text(title)
                .font(.system(size: 24))
                .fontWeight(.semibold)
                .foregroundColor(color)
                //.foregroundColor(color == nil ? Color("Dark1") : color)
            Spacer()
            Button {
                isActive.toggle()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(color)
                //    .foregroundColor(color == nil ? Color("Dark1") : color)
                    .font(Font.system(size: 20, weight: .semibold))
            }
        }.padding(.top, 48)
        .padding()
    }
}


struct WidgetSolo: View {
    
    var image: String
    var size: Int? = 48
    var firstLine: String
    var secondLine: String
    var secondLineColor: Color? = Color("Gray2")
    var buttonTitle: String? = ""
    
    @Binding var isActive: Bool
    
    
    var body: some View {
        Button {
            isActive.toggle()
        } label: {
            HStack {
                Image(systemName: image)
                    .foregroundColor(Color("ThemePrimary"))
                    .font(.system(size: CGFloat(size!)))
                VStack(alignment: .leading, spacing: 3) {
                    Text(firstLine)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Dark1"))
                    Text(secondLine)
                        .font(secondLineColor! == Color("Gray2") ? .system(size: 16) : .system(size: 14))
                        .fontWeight(secondLineColor! == Color("Gray2") ? .regular : .semibold)
                        .foregroundColor(secondLineColor)
                }
                Spacer()
                if !buttonTitle!.isEmpty {
                    Text(buttonTitle!)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Dark1"))
                        .padding(.vertical, 6)
                        .padding(.horizontal, 16)
                        .background(RoundedRectangle(cornerRadius: 16).foregroundColor(Color("Background")))

                } else {
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color("Gray2"))
                        .font(Font.system(size: 15, weight: .semibold))
                }
            }.padding(.horizontal, 12)
            .padding(.vertical)
            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
        }
        .padding(.horizontal)
    }
}



struct RewardsProgramWidget: View {

    var image: String
    var company: String
    var status: String
    var currentPointsBalance: Int
    
    var body: some View {

        HStack (alignment: .center) {
            
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 38, height: 38, alignment: .center)
                .clipped()
                .cornerRadius(12)
                .padding(.trailing, 6)
//                Image(systemName: "person.crop.circle")
//                    .foregroundColor(.black)
//                    .font(.system(size: 30))
            
            VStack(alignment: .leading) {
                Text(company)
                    .foregroundColor(Color("Dark1"))
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                if status != "None" {
                    //Text(status)
                    Text("GOLD")
                        //.kerning(1.8)
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .foregroundColor(Color("Gray1"))
                }
            }
//            Text("Gold")
//                .font(.system(size: 14))
//                .fontWeight(.semibold)
//                //.foregroundColor(Color("Dark1"))
//                .foregroundColor(Color("Gold1"))
//                .padding(.vertical, 6)
//                .padding(.horizontal, 12)
//                .background(RoundedRectangle(cornerRadius: 22)
//                    //.foregroundColor(Color("Background")))
//                    .foregroundColor(Color("Gold2")))
//                .padding(.leading, 6)
            
            Spacer()
            
            Text(String(currentPointsBalance))
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundColor(Color("Dark1"))
//                .padding(.vertical, 10)
//                .padding(.horizontal, 16)
//                .background(RoundedRectangle(cornerRadius: 22)
//                    //.foregroundColor(Color("Background")))
//                    .foregroundColor(Color("Gold2")))
            
            Image(systemName: "chevron.right")
                .foregroundColor(Color("Gray3"))
                .font(Font.system(size: 15, weight: .semibold))
                .padding(.leading, 3)
            
        }.padding(.top)
    }
}

struct WideWidgetHeader: View {

    var title: String
    
    var body: some View {

        HStack {
            Text(title).kerning(1.2)
                .font(.system(size: 13))
                .fontWeight(.medium)
                .foregroundColor(Color("Gray1"))
            Spacer()
        }.padding(.horizontal).padding(.top).padding(.top)
    }
}

struct WideWidgetItem: View {

    var image: String
    var size: Int
    var color: Color? = Color("ThemePrimary")
    var title: String
    var subtitle: String? = ""
    
    var body: some View {

        HStack(alignment: .center) {
            Image(systemName: image)
                .foregroundColor(color)
                .font(.system(size: CGFloat(size)))
                .frame(width: CGFloat(size*9/5))
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Dark1"))
                if !subtitle!.isEmpty {
                    Text(subtitle!)
                        .font(.system(size: 16))
                        .fontWeight(.regular)
                        .foregroundColor(Color("Gray2"))
                }
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(Color("Gray3"))
                .font(Font.system(size: 15, weight: .semibold))
        }
    }
}


//MARK: PROMPT CARD
//Used on Home, CompanyProfile pages to prompt user to review products or refer them to friends
struct PromptCard: View {

    var image:String
    var title:String
    var points:Int
    var text: String
    var width: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            //Top part / header
            HStack (alignment: .center) {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 32, height: 32, alignment: .center)
                    .clipped()
                    .cornerRadius(32)
                    .padding(.trailing, 3)
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Dark1"))
                    Text("+" + String(points))
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("ThemeBright"))
                }
            }.padding(.bottom)
            Text(text)
                .font(.system(size: 16))
                .fontWeight(.regular)
                .foregroundColor(Color("Dark1"))
                .lineLimit(3)
                .multilineTextAlignment(.leading)
        }.frame(width: width, height: 120)
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
        .padding(.trailing, 8)
            
    }
}


//MARK: MY HISTORY
//This struct formats the discount codes that are available
struct MyHistoryItem: View {
    
    var type: String
    var timestamp: Int
    var pointsEarnedOrSpent: Int
    var colorToShow: Color
    
    var iconToShow: String {
        switch type {
            case "REFERRAL":
                return "person.2.fill"
            case "REVIEW":
                return "text.bubble.fill"
            case "ORDER":
                return "signature"
            case "DISCOUNTCODE":
                return "dollarsign.circle.fill"
            default:
                return "bag.fill"
        }
    }
    
    var textToShow: String {
        switch type {
            case "REFERRAL":
                return "Referral bonus"
            case "REVIEW":
                return "Review bonus"
            case "ORDER":
                return "Purchase"
            case "DISCOUNTCODE":
                return "Redeemed points"
            default:
                return "bag.fill"
        }
    }
    
    var body: some View {
        
        HStack {
            Image(systemName: iconToShow)
                .foregroundColor(colorToShow)
                .font(.system(size: 32))
            VStack(alignment: .leading, spacing: 3) {
                HStack(alignment: .center) {
                    Text(textToShow)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Dark1"))
                    Spacer()
                    Text(convertTimestampToString(timestamp: timestamp))
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Dark1"))
                }
                Text(String(pointsEarnedOrSpent))
                    .font(Font.system(size: 16, weight: .regular))
                    .foregroundColor(Color("Gray1"))
                
            }
        }.padding(.bottom)
    }
}

//MARK: ORDER HISTORY ITEM
//This struct formats the discount codes that are available
struct MyRecentOrdersItem: View {
    
    var item: String
    var timestamp: Int
    var reviewID: String
    var colorToShow: Color
    
    var body: some View {
        
        HStack {
            Image(systemName: "bag.circle.fill")
                .foregroundColor(colorToShow)
                .font(.system(size: 32))
            HStack(alignment: .center) {
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(item)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Dark1"))
                    Text(convertTimestampToString(timestamp: timestamp))
                        .font(Font.system(size: 15, weight: .semibold))
                        .foregroundColor(Color("Gray1"))
                }
                Spacer()
                if reviewID == "fill in later" {
                    Text("Add Review")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(colorToShow)
                } else {
                    HStack {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color("Dark1"))
                            .font(.system(size: 14))
                        Text("Reviewed")
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                            .foregroundColor(Color("Dark1"))
                    }
                }
            }
        }.padding(.vertical)
    }
}



//MARK: REVIEW - DETAILS OF PURCHASED ITEM
//Format the item details
struct OrderDetailsForReview: View {
    
    var title: String
    var value: String
    
    var body: some View {
        
        HStack(alignment: .center) {
            Text(title)
                .font(.system(size: 16))
                .fontWeight(.regular)
                .foregroundColor(Color("Dark1"))
            Spacer()
            Text(value)
                .font(Font.system(size: 16, weight: .semibold))
                .foregroundColor(Color("Dark1"))
        }.padding(.bottom)
        
    }
}


//VStack {
//    Text(String(createLast60DaysPointsArray(transactions: viewModel3.last60DaysTransactions, currentBalance: viewModel1.oneRewardsProgram.first?.currentPointsBalance ?? 0)[0]))
//}



//MARK: Line Graph for Points
//Format the item details
struct LineGraph: View {

    // number of plots
    var data: [Int]
    
    var GoldTier:Double = Double(2500)

    var maxPoint: Double {
        let max = Double(data.max() ?? 0)
        if max == 0 {
            return 1.0
        }
        return max
    }

    var body: some View {
        GeometryReader { geometry in

            ZStack {

                //let data = pointsOverTime
                
                let height = geometry.size.height
                let width = geometry.size.width

                
                // Path...
                Path { path in

                    path.move(to: CGPoint(x: 0, y: height * self.ratio(for: 0)))
                    
                    for index in 1..<data.count {
                        path.addLine(to: CGPoint(
                            x: CGFloat(index) * width / CGFloat(data.count-1),
                            y: height * self.ratio(for: index)))
                    }
                }
                .stroke(Color("ThemeBright"), style: StrokeStyle(lineWidth: 4, lineJoin: .round))
                
                Path { path in
                    path.move(to: CGPoint(x: 40, y: height * (1 - GoldTier/maxPoint)))
                    path.addLine(to: CGPoint(x: width, y: height * (1 - GoldTier/maxPoint)))
                }.stroke(Color("Gray2"), style: StrokeStyle(lineWidth: 1))
                
                Text("Gold")
                    .font(.system(size: 12))
                    .fontWeight(.regular)
                    .foregroundColor(Color("Gray2"))
                    .position(x: 20, y: height * (1 - GoldTier/maxPoint))
            }
            .padding(.vertical)
        }

    }
    
    private func ratio(for index: Int) -> Double {
        1 - (Double(data[index]) / maxPoint)
      }
    
}
