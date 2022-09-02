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
        
        VStack {
            Text(arrayOfReviewQuestions[indexOfCurrentReviewPage])
            TextField("Write here...", text: $answerForThisQuestion)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 24)
                .onSubmit {
                    
                    //add, subtract, or don't change points depending on whether answer added, removed, or updated
                    runningSumOfEarnedPoints = updatePointsForSubmission(answerForThisQuestion: answerForThisQuestion, arrayOfReviewAnswers: arrayOfReviewAnswers, runningSumOfEarnedPoints: runningSumOfEarnedPoints, arrayOfEarnablePointsForEachQuestion: arrayOfEarnablePointsForEachQuestion, indexOfCurrentReviewPage: indexOfCurrentReviewPage)
                    
                    //update the answer in the results array
                    arrayOfReviewAnswers[indexOfCurrentReviewPage] = answerForThisQuestion
                    
                    //check if next question needs the keyboard
                    if arrayOfReviewQuestionTypes[indexOfCurrentReviewPage+1] != "TEXTENTRY" {
                        hideKeyboard()
                    }
                    
                    
                    //go to the next question
                    indexOfCurrentReviewPage += 1

                    print(arrayOfReviewAnswers)
                    print(indexOfCurrentReviewPage)
                    
                    //reset the text for the answer for the next question
                    answerForThisQuestion = arrayOfReviewAnswers[indexOfCurrentReviewPage]
                }
            
            //Don't show the NEXT button on the final page
            if ((indexOfCurrentReviewPage + 1) != arrayOfReviewQuestionTypes.filter({ $0 != "" }).count) {
                ReviewPageNextButton(answerForThisQuestion: $answerForThisQuestion, arrayOfReviewAnswers: $arrayOfReviewAnswers, runningSumOfEarnedPoints: $runningSumOfEarnedPoints, overallRatingForReview: $overallRatingForReview, indexOfCurrentReviewPage: $indexOfCurrentReviewPage, arrayOfReviewQuestionTypes: $arrayOfReviewQuestionTypes, arrayOfEarnablePointsForEachQuestion: arrayOfEarnablePointsForEachQuestion, screenWidth: screenWidth)
            }
            
            //Don't show the Back button on the first page
            if indexOfCurrentReviewPage != 0 {
                ReviewPageBackButton(answerForThisQuestion: $answerForThisQuestion, arrayOfReviewAnswers: $arrayOfReviewAnswers, runningSumOfEarnedPoints: $runningSumOfEarnedPoints, overallRatingForReview: $overallRatingForReview, indexOfCurrentReviewPage: $indexOfCurrentReviewPage, arrayOfReviewQuestionTypes: $arrayOfReviewQuestionTypes, arrayOfEarnablePointsForEachQuestion: arrayOfEarnablePointsForEachQuestion, screenWidth: screenWidth)
            }
            
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
        
        }.frame(width: screenWidth, height: 300).background(.yellow)
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
