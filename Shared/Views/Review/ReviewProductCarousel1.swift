//
//  ReviewProductCarousel1.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 7/21/22.
//

import SwiftUI

struct ReviewProductCarousel1: View {

    @EnvironmentObject var viewModel: AppViewModel

    @ObservedObject var reviewsViewModel = ReviewsViewModel()
    @ObservedObject var rewardsProgramViewModel = RewardsProgramViewModel()

    
    @Binding var showingReviewProductScreen: Bool
    
    @State var horizontalOffset : CGFloat = UIScreen.main.bounds.width
    @State var rating : Int = 0
    @State var response1: String = ""
    @State var response2: String = ""
    
    @State private var blinkingOKButton: Bool = false
    
    @State var pointsEarned: Int = 0
    
    
    var companyID: String
    var itemID: String
    var email: String
    var emailUID: String
    
    var screenWidth:CGFloat = UIScreen.main.bounds.width     //this should be 428 for an iPhone 12 Pro Max
    
    var numberOfScreens:Int = 3
    
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                //Background color
                Color("Dark2")
                
                
                //MARK: VStack for ALL content on screen
                VStack(alignment: .center, spacing: 0) {
                    
                    //MARK: Vstack for HEADER content
                    VStack(spacing:0) {
                        
                        //MARK: X Button
                        HStack (alignment: .center) {
                            Spacer()
                            Button {
                                showingReviewProductScreen.toggle()
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .font(Font.system(size: 20, weight: .semibold))
                            }
                        }
                        .padding(.top, 48)
                        .padding()

                        //MARK: LEFT/RIGHT ARROWS + SCOREBOARD
                        HStack {
                            Button {
                                withAnimation(.linear(duration: 0.15)) {
                                    horizontalOffset = calculateNewHorizontalOffset(currentHorizontalOffset: horizontalOffset, numberOfQuestions: numberOfScreens, screenWidth: screenWidth, moveToTheRight: false)
                                    
                                    //horizontalOffset += geometry.size.width
                                }
                            } label: {
                                Image(systemName: "arrow.left.circle.fill")
                                    .foregroundColor(Color("ThemeBright"))
                                    .font(Font.system(size: 40, weight: .semibold))
                            }.disabled(horizontalOffset == screenWidth)

                            Button {
                                withAnimation(.linear(duration: 0.15)) {

                                    horizontalOffset = calculateNewHorizontalOffset(currentHorizontalOffset: horizontalOffset, numberOfQuestions: numberOfScreens, screenWidth: screenWidth, moveToTheRight: true)
                                    print(String(Int(horizontalOffset)))
                                    
                                    //horizontalOffset -= geometry.size.width
                                }
                            } label: {
                                ZStack {
                                    Circle()
                                        .foregroundColor(.white)
                                        .frame(width: 32, height: 32, alignment: .center)
                                    Image(systemName: "arrow.right.circle.fill")
                                        .foregroundColor(Color("ThemeBright"))
                                        .font(Font.system(size: 40, weight: .semibold))
                                }
                            }.disabled(horizontalOffset == (screenWidth - (screenWidth * CGFloat(numberOfScreens - 1))))
                            
                            Spacer()
                            Text("150 points")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Dark1"))
                        }
                        .padding(.horizontal)
                        .frame(height: 96)
                    }.frame(width: UIScreen.main.bounds.width)
                        .padding(.bottom)
                    
                    HStack(spacing: 0) {
//                        Rectangle().foregroundColor(.red)
//                            .frame(width: UIScreen.main.bounds.width)
                        
                        //MARK: PAGE 1 (Title and First Question)
                        VStack (alignment: .leading) {
                            
                            HStack(alignment: .center) {
                
                                VStack(alignment: .leading) {
                                    Text("1 / 3")
                                        .foregroundColor(Color("Dark1"))
                                        .font(.headline)
                                        .padding(.bottom, 48)
                                    Text("What would you rate this item?")
                                        .foregroundColor(Color(red: 20/255, green: 52/255, blue: 97/255))
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    Text("1 = Not good, 5 = Amazing")
                                        .foregroundColor(Color(red: 20/255, green: 52/255, blue: 97/255))
                                        .font(.body)
                                        .italic()
                                        .padding(.bottom, 24)
                                    RatingView(rating: $rating, width: screenWidth, horizontalOffset: $horizontalOffset)   //try passing $blinkingOKButton into the rating view
                
                                    Divider().opacity(0.0)
                                        .padding(.bottom, 24)
                
                                    HStack {
                                        Spacer()
                                        Button {
                                            //withAnimation(scaleEffect(1.1))
                                            //.scaleEffect(1.1)
                                            withAnimation(.easeInOut(duration: 0.12).repeatCount(3, autoreverses: true)) {
                                                blinkingOKButton.toggle()
                                            }
                
                                            withAnimation(.linear(duration: 0.15).delay(0.6)) {
                                                blinkingOKButton = false
                                                horizontalOffset -= geometry.size.width
                                            }
                                            //.animation(.easeInOut(duration: 0.2), value: rating)
                                        } label: {
                                            HStack {
                                                Text("OK")
                                                    .foregroundColor(.white)
                                                    .font(.headline)
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(.white)
                                                    .font(.headline)
                                            }.padding()
                                            .background(RoundedRectangle(cornerRadius: 8)
                                                .fill(self.rating == 0 ? Color("Gray2") : Color("ThemeBright")))
                                            .opacity(blinkingOKButton ? 0 : 1)
                                        }.disabled(self.rating == 0)
                                    }
                                }
                
                            }.padding(.horizontal)
                            Spacer()
                        }
                            .frame(width: UIScreen.main.bounds.width, alignment: .center)
                        
                        
                        
                        
                        
                        
                        
                        Rectangle().foregroundColor(.green)
                            .frame(width: UIScreen.main.bounds.width)
                        Rectangle().foregroundColor(.yellow)
                            .frame(width: UIScreen.main.bounds.width)
                    }.frame(width: UIScreen.main.bounds.width*3, height: UIScreen.main.bounds.height - CGFloat(200))
                        .offset(x:horizontalOffset)
                //Content HStack section
                }
                
                
                
                
                
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .ignoresSafeArea()
        }.onAppear {
            print(String(Int(UIScreen.main.bounds.width)))
            print("screenWidth Variable")
            print(String(Int(screenWidth)))
        }
    }
    
    
    func calculateNewHorizontalOffset(currentHorizontalOffset: CGFloat, numberOfQuestions: Int, screenWidth: CGFloat, moveToTheRight: Bool) -> CGFloat {
        
        let initialHorizontalOffset = screenWidth                   //428 for an iPhone 12 max
        let spanOfHorizontalMovement = screenWidth*CGFloat(numberOfQuestions-1) //1284 for an iPhone 12 max
        let minimumHorizontalOffset = initialHorizontalOffset - spanOfHorizontalMovement  // -856 for an iPhone 12 max
        
        print("minimum horizontal offset")
        print(String(Int(minimumHorizontalOffset)))
        
        var newHorizontalOffset = CGFloat(0)
        
        print("current horizontal offset")
        print(String(Int(currentHorizontalOffset)))
        //so we should never go past 428 or -856
        if moveToTheRight {
            newHorizontalOffset = currentHorizontalOffset - screenWidth
        } else {
            newHorizontalOffset = currentHorizontalOffset + screenWidth
        }
        
        print("new horizontal offset")
        print(String(Int(newHorizontalOffset)))
        
        if (Int(newHorizontalOffset) > Int(initialHorizontalOffset)) {          //i.e. if you've gone past +428 and you're moving too far left
            return initialHorizontalOffset
        } else if (Int(newHorizontalOffset) <= Int(minimumHorizontalOffset)) {          //i.e. if you've gone past -856 and you're moving too far right
            return minimumHorizontalOffset
        } else {
            return newHorizontalOffset
        }

    }
    
}

struct ReviewProductCarousel1_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ReviewProductCarousel1(showingReviewProductScreen: .constant(true), companyID: "zKL7SQ0jRP8351a0NnHM", itemID: "Z3GBvz1xRYuHl8Tj6Z9j", email: "colinjpower1@gmail.com", emailUID: "mhjEZCv9JGdk0NUZaHMcNrDsH1x2")
        }
    }
}


#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif





//
////Pages that you scroll through
////                ScrollView(.horizontal) {
//    HStack(spacing: 0) {
//        //MARK: PAGE 1 (Title and First Question)
//        VStack (alignment: .leading) {
//            Spacer()
//            HStack(alignment: .center) {
//
//                VStack(alignment: .leading) {
//                    Text("1 / 3")
//                        .foregroundColor(Color("Dark1"))
//                        .font(.headline)
//                        .padding(.bottom, 48)
//                    Text("What would you rate this item?")
//                        .foregroundColor(Color(red: 20/255, green: 52/255, blue: 97/255))
//                        .font(.title3)
//                        .fontWeight(.semibold)
//                    Text("1 = Not good, 5 = Amazing")
//                        .foregroundColor(Color(red: 20/255, green: 52/255, blue: 97/255))
//                        .font(.body)
//                        .italic()
//                        .padding(.bottom, 24)
//                    RatingView(rating: $rating, width: geometry.size.width, horizontalOffset: $horizontalOffset)   //try passing $blinkingOKButton into the rating view
//
//                    Divider().opacity(0.0)
//                        .padding(.bottom, 24)
//
//                    HStack {
//                        Spacer()
//                        Button {
//                            //withAnimation(scaleEffect(1.1))
//                            //.scaleEffect(1.1)
//                            withAnimation(.easeInOut(duration: 0.12).repeatCount(3, autoreverses: true)) {
//                                blinkingOKButton.toggle()
//                            }
//
//                            withAnimation(.linear(duration: 0.15).delay(0.6)) {
//                                blinkingOKButton = false
//                                horizontalOffset -= geometry.size.width
//                            }
//                            //.animation(.easeInOut(duration: 0.2), value: rating)
//                        } label: {
//                            HStack {
//                                Text("OK")
//                                    .foregroundColor(.white)
//                                    .font(.headline)
//                                Image(systemName: "checkmark")
//                                    .foregroundColor(.white)
//                                    .font(.headline)
//                            }.padding()
//                            .background(RoundedRectangle(cornerRadius: 8)
//                                .fill(self.rating == 0 ? Color("Gray2") : Color("ThemeBright")))
//                            .opacity(blinkingOKButton ? 0 : 1)
//                        }.disabled(self.rating == 0)
//                    }
//                }
//
//            }.padding(.horizontal)
//            Spacer()
//        }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
//            .offset(x: horizontalOffset)
//
//
//        //MARK: PAGE 2 (Second Question)
//        VStack (alignment: .leading) {
//            Spacer()
//            HStack(alignment: .center) {
//
//                VStack(alignment: .leading) {
//                    Text("2 / 3")
//                        .foregroundColor(Color("Dark1"))
//                        .font(.headline)
//                        .padding(.bottom, 48)
//                    Text("How would you describe the quality of the fabric?")
//                        .foregroundColor(Color(red: 20/255, green: 52/255, blue: 97/255))
//                        .font(.title3)
//                        .fontWeight(.semibold)
//                        .padding(.bottom, 24)
//                    TextField("Write here...", text: $response1)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding(.bottom, 24)
//
//                    HStack {
//                        Button {
//                            withAnimation(.linear(duration: 0.15)) {
//                                horizontalOffset += geometry.size.width
//                            }
//                        } label: {
//                            Image(systemName: "arrow.left.circle.fill")
//                                .foregroundColor(Color("ThemeBright"))
//                                .font(Font.system(size: 40, weight: .semibold))
//                        }.disabled(horizontalOffset == 0)
//                        Spacer()
//                        Button {
//                            withAnimation(.linear(duration: 0.15).delay(0.5)) {
//                                horizontalOffset -= geometry.size.width
//                                hideKeyboard()
//                            }
//                        } label: {
//                            HStack {
//                                Text("OK")
//                                    .foregroundColor(.white)
//                                    .font(.headline)
//                                Image(systemName: "checkmark")
//                                    .foregroundColor(.white)
//                                    .font(.headline)
//                            }.padding()
//                            .background(RoundedRectangle(cornerRadius: 8)
//                                //.fill(Color("ThemeBright"))
//                                .fill(self.response1 == "" ? Color("Gray2") : Color("ThemeBright")))
//                        }
//                    }
//                }
//
//            }.padding(.horizontal)
//            Spacer()
//        }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
//            .offset(x: horizontalOffset)
//
//
//        //MARK: Page 3 (final question and completion)
//        VStack (alignment: .leading) {
//            Spacer()
//            HStack(alignment: .center) {
//
//                //The stacked question + button
//                VStack(alignment: .center) {
//
//                    //The section above
//                    VStack(alignment: .leading) {
//                        Text("3 / 3")
//                            .foregroundColor(Color("Dark1"))
//                            .font(.headline)
//                            .padding(.bottom, 48)
//                        Text("How was the shipping process?")
//                            .foregroundColor(Color(red: 20/255, green: 52/255, blue: 97/255))
//                            .font(.title3)
//                            .fontWeight(.semibold)
//                            .padding(.bottom, 24)
//                        TextField("Write here...", text: $response2)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                            .padding(.bottom, 24)
//                        Divider()
//                            .padding(.bottom, 24)
//                    }
//
//                    //Submit Button
//                    HStack {
//                        Spacer()
//                        Button {
//                            //NEED TO POST BACK TO FIREBASE HERE
//                            reviewsViewModel.addReview(companyID: companyID, email: email, itemID: itemID, reviewRating: rating, questionsArray: ["q1", "q2"], responsesArray: [response1, response2], reviewTitle: "blank title", userID: emailUID)
//                            rewardsProgramViewModel.updateLoyaltyPointsForReason(userID: emailUID, companyID: companyID, changeInPoints: 100, reason: "SubmittedReview")
//                            showingReviewProductScreen = false
//                        } label: {
//                            HStack {
//                                Text("Submit")
//                                    .foregroundColor(.white)
//                                    .font(.headline)
//                                Image(systemName: "checkmark")
//                                    .foregroundColor(.white)
//                                    .font(.headline)
//                            }.padding()
//                            .padding(.horizontal, 32)
//                            .background(RoundedRectangle(cornerRadius: 8)
//                            .fill(Color(red: 20/255, green: 52/255, blue: 97/255)))
//                        }
//                    }
//
//                }
//
//            }.padding(.horizontal)
//            Spacer()
//        }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
//            .offset(x: horizontalOffset)
//    }
//    .frame(width: geometry.size.width*3)
//    .ignoresSafeArea(.keyboard)
////                }
