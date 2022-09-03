//
//  ReviewPageWithTextEntry.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/2/22.
//

import SwiftUI

struct ReviewPageWithTextEntry: View {
    
    //Environment
    
    //ViewModels
    
    //State
    @State var answerForThisQuestion:String = ""
    
    //Binding
    @Binding var arrayOfReviewAnswers:[String]
    @Binding var runningSumOfEarnedPoints:Double
    @Binding var overallRatingForReview:Int
    @Binding var indexOfCurrentReviewPage:Int
    
    
    //Required variables
    @Binding var arrayOfReviewQuestions:[String]
    @Binding var arrayOfReviewQuestionTypes:[String]
    var arrayOfEarnablePointsForEachQuestion: [Double]
    var screenWidth:CGFloat
    //var index:Int
    
    
    
    
    
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            Text(arrayOfReviewQuestions[indexOfCurrentReviewPage])
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.leading)
                .foregroundColor(Color("Dark1"))
                .padding(.top, 60)
                .padding(.bottom, 20)
                .padding(.horizontal)
                .frame(height: 140, alignment: .leading)
            
            
            TextField("Write here...", text: $answerForThisQuestion)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.vertical, 20)
                .padding(.horizontal)
                .frame(height: 80, alignment: .center)
                .onSubmit {
                    
                    //add, subtract, or don't change points depending on whether answer added, removed, or updated
                    withAnimation {
                        runningSumOfEarnedPoints = updatePointsForSubmission(answerForThisQuestion: answerForThisQuestion, arrayOfReviewAnswers: arrayOfReviewAnswers, runningSumOfEarnedPoints: runningSumOfEarnedPoints, arrayOfEarnablePointsForEachQuestion: arrayOfEarnablePointsForEachQuestion, indexOfCurrentReviewPage: indexOfCurrentReviewPage)
                    }
                    
                    //update the answer in the results array
                    arrayOfReviewAnswers[indexOfCurrentReviewPage] = answerForThisQuestion
                    
                    //check if next question needs the keyboard
                    if arrayOfReviewQuestionTypes[indexOfCurrentReviewPage+1] != "TEXTENTRY" {
                        hideKeyboard()
                    }
                    
                    
                    //go to the next question
                    withAnimation(.linear(duration: 0.15)) {
                        indexOfCurrentReviewPage += 1
                    }

                    print(arrayOfReviewAnswers)
                    
                    //reset the text for the answer for the next question
                    answerForThisQuestion = arrayOfReviewAnswers[indexOfCurrentReviewPage]
                }
            
            
            HStack(alignment: .center) {
                
                //MARK: BACK BUTTON
                //Don't show the Back button on the first page
                if indexOfCurrentReviewPage != 0 {
                    
                    //Don't show the Back button on the first page
                    ReviewPageBackButton(answerForThisQuestion: $answerForThisQuestion, arrayOfReviewAnswers: $arrayOfReviewAnswers, runningSumOfEarnedPoints: $runningSumOfEarnedPoints, overallRatingForReview: $overallRatingForReview, indexOfCurrentReviewPage: $indexOfCurrentReviewPage, arrayOfReviewQuestionTypes: $arrayOfReviewQuestionTypes, arrayOfEarnablePointsForEachQuestion: arrayOfEarnablePointsForEachQuestion, screenWidth: screenWidth)
                    
                } else {
                    
                    Rectangle().foregroundColor(.clear).frame(width: 48, height: 48)
                    
                }
                
                Spacer()
                
                //MARK: NEXT BUTTON
                //Don't show the NEXT button on the final page
                if ((indexOfCurrentReviewPage + 1) != arrayOfReviewQuestionTypes.filter({ $0 != "" }).count) {
                    
                    ReviewPageNextButton(answerForThisQuestion: $answerForThisQuestion, arrayOfReviewAnswers: $arrayOfReviewAnswers, runningSumOfEarnedPoints: $runningSumOfEarnedPoints, overallRatingForReview: $overallRatingForReview, indexOfCurrentReviewPage: $indexOfCurrentReviewPage, arrayOfReviewQuestionTypes: $arrayOfReviewQuestionTypes, arrayOfEarnablePointsForEachQuestion: arrayOfEarnablePointsForEachQuestion, screenWidth: screenWidth)
                    
                } else {
                    
                    //need to change this to the "SEE PREVIEW" button
                    ReviewPageNextButton(answerForThisQuestion: $answerForThisQuestion, arrayOfReviewAnswers: $arrayOfReviewAnswers, runningSumOfEarnedPoints: $runningSumOfEarnedPoints, overallRatingForReview: $overallRatingForReview, indexOfCurrentReviewPage: $indexOfCurrentReviewPage, arrayOfReviewQuestionTypes: $arrayOfReviewQuestionTypes, arrayOfEarnablePointsForEachQuestion: arrayOfEarnablePointsForEachQuestion, screenWidth: screenWidth)
                    
                }
            }
            .padding(.top, 20)
            .padding(.horizontal)
            .frame(height: 70, alignment: .center)
            
            Spacer()
            
            
            
            
            
            
//            //Don't show the NEXT button on the final page
//            if ((indexOfCurrentReviewPage + 1) != arrayOfReviewQuestionTypes.filter({ $0 != "" }).count) {
//                ReviewPageNextButton(answerForThisQuestion: $answerForThisQuestion, arrayOfReviewAnswers: $arrayOfReviewAnswers, runningSumOfEarnedPoints: $runningSumOfEarnedPoints, overallRatingForReview: $overallRatingForReview, indexOfCurrentReviewPage: $indexOfCurrentReviewPage, arrayOfReviewQuestionTypes: $arrayOfReviewQuestionTypes, arrayOfEarnablePointsForEachQuestion: arrayOfEarnablePointsForEachQuestion, screenWidth: screenWidth)
//            }
            
//            else {
//                
//                ReviewPageButton(answerForThisQuestion: $answerForThisQuestion, arrayOfReviewAnswers: $arrayOfReviewAnswers, runningSumOfEarnedPoints: $runningSumOfEarnedPoints, overallRatingForReview: $overallRatingForReview, indexOfCurrentReviewPage: $indexOfCurrentReviewPage, arrayOfReviewQuestionTypes: $arrayOfReviewQuestionTypes, arrayOfEarnablePointsForEachQuestion: arrayOfEarnablePointsForEachQuestion, screenWidth: screenWidth)
//
//            }
            
            //
            
//            ReviewPageNextButton(runningSumOfEarnedPoints: $runningSumOfEarnedPoints, resultingArray: $resultingArray, currentQuestion: $currentQuestion, textEntryText: textEntryText, screenWidth: screenWidth, index: index)
            
            
//            ReviewPageBackButton(pointsEarned: $pointsEarned, resultingArray: $resultingArray, currentQuestion: $currentQuestion, textEntryText: textEntryText, screenWidth: screenWidth, index: index)
//
//            Button {
//                pointsEarned = updatePointsForSubmission(answers: resultingArray, newAnswer: textEntryText, index: index, currentPoints: pointsEarned, pointsForThisQuestion: Double(100))
//
//                //update the answer in the results array
//                resultingArray[index] = textEntryText
//
//                //go to the prior question
//                currentQuestion -= 1
//            } label: {
//                Text("Back")
//            }
        
        }.ignoresSafeArea()
            .frame(width: screenWidth, height: UIScreen.main.bounds.height-260)
            .onAppear {
                print("We're on page \(indexOfCurrentReviewPage)")
                //print(reviewQuestionForThisPage)
            }
    }
}

//struct ReviewPage_TextEntry_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewPage_TextEntry()
//    }
//}
