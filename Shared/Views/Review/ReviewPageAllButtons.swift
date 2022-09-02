//
//  ReviewPageAllButtons.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/2/22.
//

import SwiftUI

struct ReviewPageAllButtons: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


struct ReviewPageNextButton: View {
    
    //State
    @Binding var answerForThisQuestion:String
    
    //Binding
    @Binding var arrayOfReviewAnswers:[String]
    @Binding var runningSumOfEarnedPoints:Double
    @Binding var overallRatingForReview:Int
    @Binding var indexOfCurrentReviewPage:Int
    @Binding var arrayOfReviewQuestionTypes:[String]
    
    
    //Required variables
    var arrayOfEarnablePointsForEachQuestion: [Double]
    var screenWidth:CGFloat
    
    var body: some View {
        Button {
            print("NEXT TAPPED.... THE CURRENT INDEX IS \(indexOfCurrentReviewPage)")
            
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
            
            print("AND NOW IT IS \(indexOfCurrentReviewPage)")
            
        } label: {
            Text("Next").padding().foregroundColor(.white).background(.blue)
        }
    }
}


struct ReviewPageBackButton: View {
    
    //State
    @Binding var answerForThisQuestion:String
    
    //Binding
    @Binding var arrayOfReviewAnswers:[String]
    @Binding var runningSumOfEarnedPoints:Double
    @Binding var overallRatingForReview:Int
    @Binding var indexOfCurrentReviewPage:Int
    @Binding var arrayOfReviewQuestionTypes:[String]
    
    
    //Required variables
    var arrayOfEarnablePointsForEachQuestion: [Double]
    var screenWidth:CGFloat
    
    var body: some View {
        Button {
            print("BACK TAPPED.... THE CURRENT INDEX IS \(indexOfCurrentReviewPage)")
            
            //add, subtract, or don't change points depending on whether answer added, removed, or updated
            runningSumOfEarnedPoints = updatePointsForSubmission(answerForThisQuestion: answerForThisQuestion, arrayOfReviewAnswers: arrayOfReviewAnswers, runningSumOfEarnedPoints: runningSumOfEarnedPoints, arrayOfEarnablePointsForEachQuestion: arrayOfEarnablePointsForEachQuestion, indexOfCurrentReviewPage: indexOfCurrentReviewPage)
            
            //update the answer in the results array
            arrayOfReviewAnswers[indexOfCurrentReviewPage] = answerForThisQuestion

            //check if prior question needs the keyboard
            if arrayOfReviewQuestionTypes[indexOfCurrentReviewPage-1] != "TEXTENTRY" {
                hideKeyboard()
            }
            
            //go to the prior question
            indexOfCurrentReviewPage -= 1

            print(arrayOfReviewAnswers)
            print(indexOfCurrentReviewPage)
            
            //reset the text for the answer for the next question
            answerForThisQuestion = arrayOfReviewAnswers[indexOfCurrentReviewPage]
            
            print("AND NOW IT IS \(indexOfCurrentReviewPage)")
            
        } label: {
            Text("Back").padding().foregroundColor(.white).background(.green)
        }
    }
}




//struct ReviewPageBackButton: View {
//
//    @Binding var pointsEarned:Double
//    @Binding var resultingArray:[String]
//    @Binding var currentQuestion:Int
//
//    var textEntryText:String
//    var screenWidth:CGFloat
//    var index:Int
//
//    var body: some View {
//        Button {
//            pointsEarned = updatePointsForSubmission(answers: resultingArray, newAnswer: textEntryText, index: index, currentPoints: pointsEarned, pointsForThisQuestion: Double(100))
//
//            //update the answer in the results array
//            resultingArray[index] = textEntryText
//
//            //go to the next question
//            currentQuestion -= 1
//
//        } label: {
//            Text("Back").padding().background(.blue)
//        }
//    }
//}





struct ReviewPageAllButtons_Previews: PreviewProvider {
    static var previews: some View {
        ReviewPageAllButtons()
    }
}
