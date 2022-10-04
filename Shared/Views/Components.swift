//
//  Components.swift
//  Uncommon Loyalty
//
//  Created by Colin Power on 8/4/22.
//

import SwiftUI
import Foundation
import SDWebImageSwiftUI
import FirebaseStorage


//Environment

//ViewModels

//State

//Binding

//Required variables




////MARK: PAGE HEADER
//struct PageHeader: View {
//    
//    @Binding var isProfileActive:Bool
//    
//    var pageTitle: String
//    
//    var body: some View {
//        HStack(alignment: .center){
//            Text(pageTitle)
//                .font(.system(size: 24))
//                .fontWeight(.semibold)
//                .foregroundColor(Color("Dark1"))
//            Spacer()
//            Button {
//                isProfileActive.toggle()
//            } label: {
//                Image(systemName: "person.crop.circle")
//                    .foregroundColor(Color("Dark1"))
//                    .font(.system(size: 30))
//            }.fullScreenCover(isPresented: $isProfileActive, content: {
//                Profile(isProfileActive: $isProfileActive)
//            })
//        }.padding(.horizontal)
//            .padding(.top, 60)
//    }
//}








//MARK: TABVIEW
struct MyTabView: View {
    
    @Binding var selectedTab:Int
    
    var body: some View {
        VStack(spacing: 0) {
            Divider().frame(height: 0.5).padding(.bottom, 10)
            HStack(alignment: .bottom) {
                Spacer()
                TabViewItem(position: 0, selectedTab: $selectedTab)
                TabViewItem(position: 1, selectedTab: $selectedTab)
                TabViewItem(position: 2, selectedTab: $selectedTab)
                TabViewItem(position: 3, selectedTab: $selectedTab)
                Spacer()
            }.padding(.horizontal)
            Spacer()
        }.edgesIgnoringSafeArea(.bottom)
        .frame(height: 80)
        .background(Color("Background"))
    }
    
}


//MARK: TABVIEW
struct TabViewItem: View {
    
    var position: Int
    @Binding var selectedTab:Int
    
    var tabViewItemImageName: [String] {
        switch position {
        case 0:
            return ["bag", "Purchases"]
        case 1:
            return ["barcode.viewfinder", "Referral Tracker"]
        case 2:
            return ["giftcard", "Rewards"]
        case 3:
            return ["person", "Profile"]
        default:
            return ["person", "Profile"]
        }
    }
    
    var body: some View {

            Button {
                selectedTab = position
            } label: {
                VStack (alignment: .center) {
                    
                    Image(systemName: tabViewItemImageName[0])
                        .foregroundColor(selectedTab == position ? Color("ThemePrimary") : .gray)
                        .font(.system(size: 25, weight: .regular))
                    Spacer()
                    Text(tabViewItemImageName[1])
                        .foregroundColor(selectedTab == position ? Color("ThemePrimary") : .gray)
                        .font(.system(size: 10, weight: .medium))
                    
                }
            }.frame(maxWidth: .infinity, maxHeight: 36)
    }
}

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}



//MARK: BOTTOM CAPSULE BUTTON SHAPE
struct BottomCapsuleButton: View {
    
    var buttonText: String
    var color: Color
    
    var body: some View {
        
        HStack {
            Spacer()
            Text(buttonText)
                .foregroundColor(Color.white)
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .padding(.vertical, 16)
            Spacer()
        }.clipShape(Capsule())
             .background(Capsule().foregroundColor(color))
         .padding(.horizontal)
         .padding(.horizontal)
         .padding(.bottom, 60)
    }
}




//MARK: SHEET HEADER
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

//MARK: ALERT ITEM
struct AlertItem: Identifiable {
  var id = UUID()
  var title: String
  var message: String
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
                .foregroundColor(Color("Gray1"))
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
    var itemID: String
    //private var urlForItem: String = ""
    
    
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            //MARK: THE IMAGE
            ZStack (alignment: .topLeading) {
//                if urlForItem != "" {
//                    WebImage(url: URL(string: urlForItem)!)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .cornerRadius(30)
//                        .frame(height: 250)
//                } else {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(30)
                    .frame(height: 150)
//                }
                Image(systemName: "circle.fill")
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundColor(.white)
                Image(systemName: "star.circle.fill")
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundColor(Color("ThemePrimary"))
            }
            
            Text("Write a review")
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundColor(Color("Dark1"))
            Text("+" + String(points) + "points")
                .font(.system(size: 14))
                .fontWeight(.semibold)
                .foregroundColor(Color("ThemeBright"))
            
        }.frame(width: 130, height: 180)
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white).shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10))
        .padding(.trailing, 8)
            
    }
}







//MARK: QUICK ACTIONS ITEM
//This struct formats the discount codes that are available
struct MyQuickActionsItem: View {
    
    var companyImage: String
    var company: String
    var item: String
    var action: String
    //var colorToShow: Color
    
    var body: some View {
        
        HStack {
            Image(companyImage)
                .resizable()
                .scaledToFill()
                .frame(width: 32, height: 32, alignment: .center)
                .clipped()
                .cornerRadius(32)
                .padding(.trailing, 6)
                
            HStack(alignment: .center) {
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(company)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Dark1"))
                    Text(item)
                        .font(Font.system(size: 15, weight: .semibold))
                        .foregroundColor(Color("Gray1"))
                }
                Spacer()
                if action == "Review" {
                    Text("Add Review")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("ThemePrimary"))
                } else {
                    HStack {
                        Text("Refer")
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                            .foregroundColor(Color("ThemePrimary"))
                    }
                }
            }
        }.padding(.bottom)
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



var cardColorOptions: [[Any]] = [
    [Color("ReviewTealImage"), Color("Yoga"), "normal", "Robin"],
    [Color("ThemeLight"), Color("ThemeAction"), "normal", "Uncommon"],
    [Color.green, Color.white, "normal", "Green"],
    [Color.yellow, Color.gray, "normal", "Yellow"],
    [Color.blue, Color.white, "normal", "Blue"],
    [Color("Gold1"), Color.white, "engraved", "Gold"],
    [Color.white, Color.white, "engraved", "White"],
    [Color("CardTeal"), Color.white, "engraved", "Teal"]
]


