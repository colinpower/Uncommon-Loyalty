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
    
    @State var horizontalOffset : CGFloat = 0
    @State var rating : Int = 0
    @State var response1: String = ""
    @State var response2: String = ""
    
    @State private var blinkingOKButton: Bool = false
    
    var companyID: String
    var itemID: String
    var email: String
    var emailUID: String
    
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                //Background color
                Color("Background")
                
                //Pages that you scroll through
//                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        //MARK: PAGE 1 (Title and First Question)
                        VStack (alignment: .leading) {
                            Spacer()
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
                                    RatingView(rating: $rating, width: geometry.size.width, horizontalOffset: $horizontalOffset)   //try passing $blinkingOKButton into the rating view

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
                        }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                            .offset(x: horizontalOffset)
                        
                        
                        //MARK: PAGE 2 (Second Question)
                        VStack (alignment: .leading) {
                            Spacer()
                            HStack(alignment: .center) {

                                VStack(alignment: .leading) {
                                    Text("2 / 3")
                                        .foregroundColor(Color("Dark1"))
                                        .font(.headline)
                                        .padding(.bottom, 48)
                                    Text("How would you describe the quality of the fabric?")
                                        .foregroundColor(Color(red: 20/255, green: 52/255, blue: 97/255))
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .padding(.bottom, 24)
                                    TextField("Write here...", text: $response1)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(.bottom, 24)

                                    HStack {
                                        Button {
                                            withAnimation(.linear(duration: 0.15)) {
                                                horizontalOffset += geometry.size.width
                                            }
                                        } label: {
                                            Image(systemName: "arrow.left.circle.fill")
                                                .foregroundColor(Color("ThemeBright"))
                                                .font(Font.system(size: 40, weight: .semibold))
                                        }.disabled(horizontalOffset == 0)
                                        Spacer()
                                        Button {
                                            withAnimation(.linear(duration: 0.15).delay(0.5)) {
                                                horizontalOffset -= geometry.size.width
                                                hideKeyboard()
                                            }
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
                                                //.fill(Color("ThemeBright"))
                                                .fill(self.response1 == "" ? Color("Gray2") : Color("ThemeBright")))
                                        }
                                    }
                                }

                            }.padding(.horizontal)
                            Spacer()
                        }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                            .offset(x: horizontalOffset)
                        
                        
                        //MARK: Page 3 (final question and completion)
                        VStack (alignment: .leading) {
                            Spacer()
                            HStack(alignment: .center) {

                                //The stacked question + button
                                VStack(alignment: .center) {

                                    //The section above
                                    VStack(alignment: .leading) {
                                        Text("3 / 3")
                                            .foregroundColor(Color("Dark1"))
                                            .font(.headline)
                                            .padding(.bottom, 48)
                                        Text("How was the shipping process?")
                                            .foregroundColor(Color(red: 20/255, green: 52/255, blue: 97/255))
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                            .padding(.bottom, 24)
                                        TextField("Write here...", text: $response2)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .padding(.bottom, 24)
                                        Divider()
                                            .padding(.bottom, 24)
                                    }

                                    //Submit Button
                                    HStack {
                                        Spacer()
                                        Button {
                                            //NEED TO POST BACK TO FIREBASE HERE
                                            reviewsViewModel.addReview(companyID: companyID, email: email, itemID: itemID, reviewRating: rating, questionsArray: ["q1", "q2"], responsesArray: [response1, response2], reviewTitle: "blank title", userID: emailUID)
                                            rewardsProgramViewModel.updateLoyaltyPointsForReason(userID: emailUID, companyID: companyID, changeInPoints: 100, reason: "SubmittedReview")
                                            showingReviewProductScreen = false
                                        } label: {
                                            HStack {
                                                Text("Submit")
                                                    .foregroundColor(.white)
                                                    .font(.headline)
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(.white)
                                                    .font(.headline)
                                            }.padding()
                                            .padding(.horizontal, 32)
                                            .background(RoundedRectangle(cornerRadius: 8)
                                            .fill(Color(red: 20/255, green: 52/255, blue: 97/255)))
                                        }
                                    }
                                    
                                }

                            }.padding(.horizontal)
                            Spacer()
                        }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                            .offset(x: horizontalOffset)
                    }
                    .frame(width: geometry.size.width*3)
                    .ignoresSafeArea(.keyboard)
//                }
                
                
                
                
                // X button, footer, header
                VStack(spacing:0) {
                    ZStack {
                        Color("Background")
                        SheetHeader(title: "Joggers 2.0", isActive: $showingReviewProductScreen)
                    }.frame(height: 108)
                    Spacer()
                    ZStack {
                        Color("Background")
                        HStack {
                            Button {
                                withAnimation(.linear(duration: 0.15)) {
                                    horizontalOffset += geometry.size.width
                                }
                            } label: {
                                Image(systemName: "arrow.left.circle.fill")
                                    .foregroundColor(Color("ThemeBright"))
                                    .font(Font.system(size: 40, weight: .semibold))
                            }.disabled(horizontalOffset == 0)

                            Button {
                                withAnimation(.linear(duration: 0.15)) {
                                    horizontalOffset -= geometry.size.width
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
                            } //.disabled(verticalOffset == 0)
                            
                            Spacer()
                            Text("150 points")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Dark1"))
                        }.padding(.horizontal)
                    }.frame(height: 96)
                }
            }
            .ignoresSafeArea()
            
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
