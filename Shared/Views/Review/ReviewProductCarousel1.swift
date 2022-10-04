//
//  ReviewProductCarousel1.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 7/21/22.
//

import SwiftUI

struct ReviewProductCarousel1: View {

    //Environment
    @EnvironmentObject var viewModel: AppViewModel

    //ViewModels
    @ObservedObject var reviewsViewModel = ReviewsViewModel()
    @ObservedObject var rewardsProgramViewModel = RewardsProgramViewModel()

    //State
    
    @State var arrayOfReviewAnswers: [String] = [String](repeating: "", count: 8)
    @State var runningSumOfEarnedPoints: Double = 0
    @State var overallRatingForReview:Int = -1
    @State var indexOfCurrentReviewPage:Int = 0
    
    //Binding
    @Binding var isShowingReviewExperience: Bool
    
    //Variables that will later be pulled from Firebase directly
    @State var arrayOfReviewQuestions: [String] = ["Overall, how would you rate these Joggers?", "What's your favorite thing about them?", "What's a good title for this review?", "PREVIEW"]   //eventually will just pull from the viewmodel for this
    @State var arrayOfReviewQuestionTypes: [String] = ["RATING", "TEXTENTRY", "TEXTENTRY", "PREVIEW"]   //eventually will just pull from the viewmodel for this
    @State var arrayOfEarnablePointsForEachQuestion: [Double] = [Double(50), Double(75), Double(125)]  //eventually will just pull from the viewmodel for this
    
    var item: Items       //Should rename this to just "item" so it's cleaner
    
    @Binding var activeReviewOrReferSheet: ActiveReviewOrReferSheet?
    
    
    var pointsPerQuestion:Int {
        switch indexOfCurrentReviewPage {
        case 0:
            return 50
        case 1:
            return 75
        case 2:
            return 125
        default:
            return 0
        }
    }
    
    
    
    //Required variables
    var screenWidth:CGFloat = UIScreen.main.bounds.width     //this should be 428 for an iPhone 12 Pro Max
    
    
    var body: some View {
        
        //MARK: The VStack containing the entire review flow
        VStack(alignment: .leading, spacing: 0) {
            
            //MARK: HEADER WITH DYNAMIC "EARNED POINTS"
            VStack(alignment: .center) {
                
                //The top bar
                HStack(alignment: .center) {
                    
                    Label {
                        HStack(alignment: .center, spacing: 12) {
                            Text("Question \(indexOfCurrentReviewPage+1)")
                                .font(.system(size: 23, weight: .semibold))
                                .foregroundColor(Color("Dark1"))
                            Text("(+" + String(pointsPerQuestion) + ")")
                                .font(.system(size: 23, weight: .bold, design: .rounded))
                                .foregroundColor(Color("ReviewTeal"))
                        }
                    } icon: {
                        ZStack(alignment: .center) {
                            Circle()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                            Image(systemName: "star.square.fill")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(Color("ReviewTeal"))
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        isShowingReviewExperience.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color("Dark1"))
                            .frame(width: 24, height: 24)
                    }
                    
                }.padding(.horizontal)
                    .padding(.top, 80)

                //The dynamic "Earned points"
                VStack(spacing: 6) {
                    Color.clear
                        .frame(width: screenWidth/3, height: 72, alignment: .trailing)
                        .animatingOverlay(for: runningSumOfEarnedPoints)
                    Text("Points Earned")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(Color("Dark1"))
                }.padding(.vertical).padding(.top)
            }
            .frame(width: screenWidth, height: 260)
            
            
            
            //MARK: CONTENT & HORIZONTAL SCROLLVIEW
            Color.clear.overlay(
                HStack(spacing: 0) {
                    
                    ForEach(Array(arrayOfReviewQuestionTypes.enumerated()), id: \.element) { index, element in
                        
                        //Switch based on the type of question it is
                        if element.description == "TEXTENTRY" {
                            
                            //must pass in all variables needed
                            ReviewPageWithTextEntry(arrayOfReviewAnswers: $arrayOfReviewAnswers, runningSumOfEarnedPoints: $runningSumOfEarnedPoints, overallRatingForReview: $overallRatingForReview, indexOfCurrentReviewPage: $indexOfCurrentReviewPage, arrayOfReviewQuestions: $arrayOfReviewQuestions, arrayOfReviewQuestionTypes: $arrayOfReviewQuestionTypes, arrayOfEarnablePointsForEachQuestion: arrayOfEarnablePointsForEachQuestion, screenWidth: screenWidth)
                            
                        } else if element.description == "RATING" {
                            
                            ReviewPageWithRating(arrayOfReviewAnswers: $arrayOfReviewAnswers, runningSumOfEarnedPoints: $runningSumOfEarnedPoints, overallRatingForReview: $overallRatingForReview, indexOfCurrentReviewPage: $indexOfCurrentReviewPage, arrayOfReviewQuestions: $arrayOfReviewQuestions, arrayOfReviewQuestionTypes: $arrayOfReviewQuestionTypes, arrayOfEarnablePointsForEachQuestion: arrayOfEarnablePointsForEachQuestion, screenWidth: screenWidth)
                        
                        } else if element.description == "PREVIEW" {
                            
                            ReviewPagePreview(arrayOfReviewAnswers: $arrayOfReviewAnswers, runningSumOfEarnedPoints: $runningSumOfEarnedPoints, overallRatingForReview: $overallRatingForReview, indexOfCurrentReviewPage: $indexOfCurrentReviewPage, arrayOfReviewQuestions: $arrayOfReviewQuestions, arrayOfReviewQuestionTypes: $arrayOfReviewAnswers, arrayOfEarnablePointsForEachQuestion: arrayOfEarnablePointsForEachQuestion, screenWidth: screenWidth, isShowingReviewExperience: $isShowingReviewExperience, item: item, userID: "mhjEZCv9JGdk0NUZaHMcNrDsH1x2")
                            
                            
                        }
                    }
                    
                } , alignment: .leading)
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height - 260)
            .offset(x: -1 * CGFloat(indexOfCurrentReviewPage) * screenWidth)
                        
        }.background(Color("Background"))
        .ignoresSafeArea()
        .onAppear {
            self.rewardsProgramViewModel.listenForOneRewardsProgram(userID: item.ids.userID, companyID: item.ids.companyID)
        }
        .onDisappear {
            
            activeReviewOrReferSheet = nil
            
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
                    .font(.system(size: 72, weight: .bold, design: .rounded))
                    .foregroundColor(Int(number) == 0 ? Color.gray : Color("ReviewTeal"))
            )
    }
}






func updatePointsForSubmission(answerForThisQuestion: String, arrayOfReviewAnswers: [String], runningSumOfEarnedPoints: Double, arrayOfEarnablePointsForEachQuestion: [Double], indexOfCurrentReviewPage: Int) -> Double {
    
    //first, check if this answer has any content (e.g. it might have been that the user deleted their prior submission)
    if answerForThisQuestion == "" {
        //this means the user either didn't submit anything, or deleted their prior submission
        
        //check if there was a prior answer
        if arrayOfReviewAnswers[indexOfCurrentReviewPage] == "" {
            //SCENARIO: SKIPPED - this means there was no prior answer (i.e. the user skipped the question
            
            //Do nothing. Just return the existing # of points
            return runningSumOfEarnedPoints
            
        } else {
            //SCENARIO: DELETED - this means there was a prior answer, but the new answer is blank
            
            //Calculate the correct amount of points after subtracting the points that the user previously earned
            
            return runningSumOfEarnedPoints - arrayOfEarnablePointsForEachQuestion[indexOfCurrentReviewPage]
            
            //Then, update the answer
        }
        
    } else {
        //this means that the user added some content (or they already added this before)
        
        //check if there was not a prior answer
        if arrayOfReviewAnswers[indexOfCurrentReviewPage] == "" {
            //SCENARIO: ADDED ANSWER - this means the user just added a new answer
            
            //Add points
            return runningSumOfEarnedPoints + arrayOfEarnablePointsForEachQuestion[indexOfCurrentReviewPage]
        } else {
            //SCENARIO: UPDATED / DID NOT CHANGE ANSWER - this means the user modified their prior answer or kept it the same
            
            //Do nothing. Just return existing # of points
            return runningSumOfEarnedPoints
        }
        
    }

}
