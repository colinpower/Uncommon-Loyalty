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
    
    @State var showingPositiveReviewScreen: Bool = false
    
    @State var horizontalOffset : CGFloat = UIScreen.main.bounds.width
    @State var rating : Int = 0
    @State var response1: String = ""
    @State var response2: String = ""
    
    @State private var blinkingOKButton: Bool = false
    
    @State var pointsEarned: Double = 0
    
    //@State var numberOfTotalQuestions: Int = 3
    @State var questionsArray: [String] = [String](repeating: "", count: 3)
    @State var answersArray: [String] = [String](repeating: "", count: 3)
    
    var itemObject: Items
    
//    var companyID: String
//    var itemID: String
//    var email: String
//    var emailUID: String
    
    var screenWidth:CGFloat = UIScreen.main.bounds.width     //this should be 428 for an iPhone 12 Pro Max
    
    var numberOfScreens:Int = 3
    
    
    @State var currentQuestion:Int = 0
    @State var responses: [String] = [String](repeating: "", count: 3)
    
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                //Background color
                Color("ReviewTeal")
                
                
                //MARK: VStack for ALL content on screen
                VStack(alignment: .center, spacing: 0) {
                    
                    //MARK: Vstack for HEADER content
                    VStack(spacing:0) {
                        
                        //MARK: X Button
                        HStack (alignment: .center) {
                            Spacer()
                            Button {
                                showingReviewProductScreen = false
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .font(Font.system(size: 20, weight: .semibold))
                            }
                        }
                            .padding(.top, 72)
                            .padding()

                        Color.clear
                            .frame(width: screenWidth/2, height: 72)
                            .animatingOverlay(for: pointsEarned)
                        
                        Spacer()
                        
                    }.frame(width: UIScreen.main.bounds.width, height: 240)

                        
                    
                    //MARK: HSTACK for QUESTIONS
                    HStack(spacing: 0) {
//                        Rectangle().foregroundColor(.red)
//                            .frame(width: UIScreen.main.bounds.width)
                        
                        //MARK: PAGE 1 (Title and First Question)
                        VStack (alignment: .leading) {
                                //MARK: EVERYTHING IN QUESTION 1
                                VStack(alignment: .leading) {
                                    Text("Question 1 (+100)".uppercased())
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .medium))
                                    Divider()
                                        .overlay(.white)
                                        .padding(.bottom, 32)
                                    Text("What would you rate this item?")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20, weight: .semibold))
                                    Text("1 = Not good, 5 = Amazing")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                        .italic()
                                        .padding(.bottom, 24)
                                    RatingView(rating: $rating, width: screenWidth, horizontalOffset: $horizontalOffset, questionsArray: $questionsArray, answersArray: $answersArray, responses: $responses, currentQuestion: $currentQuestion, pointsEarned: $pointsEarned)                //try passing $blinkingOKButton into the rating view
                                        .padding(.bottom)
                                }
                                .padding(.horizontal)
               
                            Spacer()
                        }.frame(width: UIScreen.main.bounds.width, alignment: .center)
                        
                        
                        
                        //MARK: PAGE 2 (Second Question)
                        VStack (alignment: .leading) {
                            VStack(alignment: .leading) {
                                Text("Question 2 (+100)".uppercased())
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .medium))
                                Divider()
                                    .overlay(.white)
                                    .padding(.bottom, 32)
                                Text("How would you describe the quality of the fabric?")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, weight: .semibold))
                                TextField("Write here...", text: $response1)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.bottom, 24)
                                    .onSubmit {
                                        //if an answer has been entered for the first time, add points
                                        if responses[currentQuestion].isEmpty {
                                            withAnimation {
                                                pointsEarned = pointsEarned + 100
                                            }
                                        }
                                        
                                        //update the response if it's been changed or added for the first time
                                        if !response1.isEmpty {
                                            questionsArray[currentQuestion] = ("How would you describe the quality of the fabric?")
                                            answersArray[currentQuestion] = (response1)
                                        }
                                        
                                        //update the question we're on (so that we're on the next one)
                                        currentQuestion += 1
                                        
                                        //move to the next screen
                                        withAnimation(.linear(duration: 0.15)) {
                                            horizontalOffset = calculateNewHorizontalOffset(currentHorizontalOffset: horizontalOffset, numberOfQuestions: numberOfScreens, screenWidth: screenWidth, moveToTheRight: true)
                                        }
                                        hideKeyboard()
                                    }
                                    .submitLabel(.done)
                                    
            
                                HStack {
                                    Spacer()
                                    Button {
                                        if answersArray[1].isEmpty {
                                            withAnimation {
                                                pointsEarned = pointsEarned + 100
                                            }
                                        }
                                        
                                        
                                        
                                        if !response1.isEmpty {
                                            questionsArray[1] = ("How would you describe the quality of the fabric?")
                                            answersArray[1] = (response1)
                                            
                                        }
                                        
                                        withAnimation(.linear(duration: 0.15)) {
                                            horizontalOffset = calculateNewHorizontalOffset(currentHorizontalOffset: horizontalOffset, numberOfQuestions: numberOfScreens, screenWidth: screenWidth, moveToTheRight: true)
                                        }
                                        
                                        
                                        
                                        hideKeyboard()
                                        print(questionsArray)
                                        print(answersArray)
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
                                            .fill(Color("ThemeBright")))
                                    }
                                }
                            }.padding(.horizontal)

                            Spacer()
                        }.frame(width: UIScreen.main.bounds.width, alignment: .center)
                        
                        
                        
                        //MARK: PAGE 3 (Third Question)
                        VStack (alignment: .leading) {
                            VStack(alignment: .leading) {
                                Text("3 / 3")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding(.bottom, 48)
                                
                                Text("How was the shipping process?")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .padding(.bottom, 24)
                                TextField("Write here...", text: $response2)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.bottom, 24)
                                    .onSubmit {
                                        if answersArray[2].isEmpty {
                                            withAnimation {
                                                pointsEarned = pointsEarned + 100
                                            }
                                        }
                                        
                                        
                                        if !response2.isEmpty {
                                            questionsArray[2] = ("How was the shipping process?")
                                            answersArray[2] = (response2)
                                        }
                                        
                                        
//                                        withAnimation(.linear(duration: 0.15)) {
//                                            horizontalOffset = calculateNewHorizontalOffset(currentHorizontalOffset: horizontalOffset, numberOfQuestions: numberOfScreens, screenWidth: screenWidth, moveToTheRight: true)
//                                        }
                                        hideKeyboard()
                                        
                                        //Post back to the reviews viewmodel
                                        
                                        reviewsViewModel.addReview(companyID: itemObject.companyID, email: itemObject.email, itemID: itemObject.itemID, reviewRating: rating, questionsArray: questionsArray, responsesArray: answersArray, reviewTitle: answersArray[1], userID: itemObject.userID)
                                        
                                        //Dismiss the prompt
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                            showingReviewProductScreen = false
                                        }
                                                                                
                                        
                                        
                                    }
                                    .submitLabel(.done)
                                    
            
                                HStack {
                                    Spacer()
                                    Button {
                                        if answersArray[2].isEmpty {
                                            withAnimation {
                                                pointsEarned = pointsEarned + 100
                                            }
                                        }
                                        
                                        if !response2.isEmpty {
                                            questionsArray[2] = ("How was the shipping process?")
                                            answersArray[2] = (response2)
                                        }
                                        
                                        hideKeyboard()
                                        print(questionsArray)
                                        print(answersArray)
                                        
                                        //Post back to the reviews viewmodel
                                        
                                        reviewsViewModel.addReview(companyID: itemObject.companyID, email: itemObject.email, itemID: itemObject.itemID, reviewRating: rating, questionsArray: questionsArray, responsesArray: answersArray, reviewTitle: answersArray[1], userID: itemObject.userID)
                                        
                                        //Trigger the celebration page
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                            
                                            showingReviewProductScreen = false
                                            showingPositiveReviewScreen = true
                                            
                                            //Dismiss the prompt
                                            
                                        }
                                        
                                        
                                    } label: {
                                        HStack {
                                            Text("Submit")
                                                .foregroundColor(.white)
                                                .font(.headline)
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.white)
                                                .font(.headline)
                                        }.padding()
                                        .background(RoundedRectangle(cornerRadius: 8)
                                            .fill(Color("ThemeBright")))
                                    }
                                }
                            }.padding(.horizontal)

                            Spacer()
                        }.frame(width: UIScreen.main.bounds.width, alignment: .center)
                        
                        
                        
                        
                        
                        
                        
                        
//                        Rectangle().foregroundColor(.yellow)
//                            .frame(width: UIScreen.main.bounds.width)
                    }.frame(width: UIScreen.main.bounds.width*3, height: 300)
                        .offset(x:horizontalOffset)
                    
                    //MARK: HSTACK for BUTTONS
                    
                    HStack(alignment: .center) {
                        //MARK: LEFT ARROW
                        Button {
                            currentQuestion -= 1
                            print("CURRENT QUESTION IS NOW")
                            print(currentQuestion)
                            withAnimation(.linear(duration: 0.15)) {
                                horizontalOffset = calculateNewHorizontalOffset(currentHorizontalOffset: horizontalOffset, numberOfQuestions: numberOfScreens, screenWidth: screenWidth, moveToTheRight: false)
                            }
                            hideKeyboard()
                        } label: {
                            if (horizontalOffset == screenWidth) {
                                //don't show the arrow, you're on the first screen
                                //empty
                            } else {
                                Image(systemName: "arrow.left")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(.white)
                                    .frame(width: 48, height: 56)
                                    .background(RoundedRectangle(cornerRadius: 8)
                                        .fill(Color("ReviewTealButton")))
                            }
                        }

                        Spacer()
                        
                        //MARK: SKIP BUTTON
                        Button {
                            
                            
                            currentQuestion += 1
                            
                            print("CURRENT QUESTION IS NOW")
                            print(currentQuestion)
                            withAnimation(.linear(duration: 0.15)) {

                                horizontalOffset = calculateNewHorizontalOffset(currentHorizontalOffset: horizontalOffset, numberOfQuestions: numberOfScreens, screenWidth: screenWidth, moveToTheRight: true)
                                print(String(Int(horizontalOffset)))

                                //horizontalOffset -= geometry.size.width
                            }
                            hideKeyboard()
                        } label: {
                            if (responses[currentQuestion] != "") {
                                //don't show "SKIP", the question's been answered
                                //empty
                            } else {
                                Text("Skip")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(.white)
                                    .frame(width: 48, height: 56)
                            }
                        }.padding(.trailing)
                        
                        //MARK: RIGHT ARROW
                        if (currentQuestion == responses.count - 1) {
                            //You're on the last question, show the SUBMIT button
                        } else {
                            //You're not on the last question
                            Button {
                                
                                
                                //NEED TO FIX THIS BUTTON SECTION!!!!
                                
                                
                                
//                                //if an answer has been entered for the first time, add points
//                                if responses[currentQuestion].isEmpty {
//                                    withAnimation {
//                                        pointsEarned = pointsEarned + 100
//                                    }
//                                }
//
//                                //update the response if it's been changed or added for the first time
//                                if !response1.isEmpty {
//                                    questionsArray[currentQuestion] = ("How would you describe the quality of the fabric?")
//                                    answersArray[currentQuestion] = (response1)
//                                }
//
//                                //update the question we're on (so that we're on the next one)
//                                currentQuestion += 1
//
//                                //move to the next screen
//                                withAnimation(.linear(duration: 0.15)) {
//                                    horizontalOffset = calculateNewHorizontalOffset(currentHorizontalOffset: horizontalOffset, numberOfQuestions: numberOfScreens, screenWidth: screenWidth, moveToTheRight: true)
//                                }
//                                hideKeyboard()
                                
                                
                                
                                
                                
                                currentQuestion += 1
                                
                                print("CURRENT QUESTION IS NOW")
                                print(currentQuestion)
                                
                                withAnimation(.linear(duration: 0.15)) {

                                    horizontalOffset = calculateNewHorizontalOffset(currentHorizontalOffset: horizontalOffset, numberOfQuestions: numberOfScreens, screenWidth: screenWidth, moveToTheRight: true)
                                    print(String(Int(horizontalOffset)))

                                    //horizontalOffset -= geometry.size.width
                                }
                                hideKeyboard()
                            } label: {
                                
                                HStack {
                                    Text("OK")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20, weight: .medium))
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20, weight: .medium))
                                }
                                .frame(width: 96, height: 56)
                                .background(RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("ReviewTealButton")))
                            }
                        }
                    }
                    .padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width, height: 96)
                        
                    Spacer()
                    
                    
                }
                

            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .ignoresSafeArea()
            .fullScreenCover(isPresented: $showingPositiveReviewScreen, content: {
                PositiveReview(showingReviewProductScreen: $showingReviewProductScreen)   //, showingPositiveReviewScreen: $showingPositiveReviewScreen)
            })
            
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

extension View {
    func animatingOverlay(for number: Double) -> some View {
        modifier(AnimatableNumberModifier(number: number))
    }
}



//struct ReviewProductCarousel1_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ReviewProductCarousel1(showingReviewProductScreen: .constant(true), companyID: "zKL7SQ0jRP8351a0NnHM", itemID: "Z3GBvz1xRYuHl8Tj6Z9j", email: "colinjpower1@gmail.com", emailUID: "mhjEZCv9JGdk0NUZaHMcNrDsH1x2")
//        }
//    }
//}


#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif




struct AnimatableNumberModifier: AnimatableModifier {
    var number: Double
    
    var animatableData: Double {
        get { number }
        set { number = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Text("\(Int(number))")
                    .font(.system(size: 72, weight: .bold))
                    .foregroundColor(Color("ThemePrimary"))
            )
    }
}
