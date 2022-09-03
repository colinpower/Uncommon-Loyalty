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
            print(indexOfCurrentReviewPage)
            
            //reset the text for the answer for the next question
            answerForThisQuestion = arrayOfReviewAnswers[indexOfCurrentReviewPage]
            
            print("AND NOW IT IS \(indexOfCurrentReviewPage)")
            
        } label: {
            HStack (alignment: .center, spacing: 2) {
                Text("OK")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                Image(systemName: "checkmark")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
            }
            .frame(width: 96, height: 48)
            .background(RoundedRectangle(cornerRadius: 12).foregroundColor(Color("ReviewTeal")))
        }
    }
}


struct ReviewPagePreviewButton: View {
    
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
            print(indexOfCurrentReviewPage)
            
            //reset the text for the answer for the next question
            answerForThisQuestion = arrayOfReviewAnswers[indexOfCurrentReviewPage]

            print("AND NOW IT IS \(indexOfCurrentReviewPage)")
            
        } label: {
            HStack (alignment: .center, spacing: 2) {
                Text("See Preview")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
                Image(systemName: "arrow.right")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.white)
            }
            .frame(width: 180, height: 48)
            .background(RoundedRectangle(cornerRadius: 12).foregroundColor(Color("ReviewTeal")))
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
            withAnimation {
                runningSumOfEarnedPoints = updatePointsForSubmission(answerForThisQuestion: answerForThisQuestion, arrayOfReviewAnswers: arrayOfReviewAnswers, runningSumOfEarnedPoints: runningSumOfEarnedPoints, arrayOfEarnablePointsForEachQuestion: arrayOfEarnablePointsForEachQuestion, indexOfCurrentReviewPage: indexOfCurrentReviewPage)
            }
            
            //update the answer in the results array
            arrayOfReviewAnswers[indexOfCurrentReviewPage] = answerForThisQuestion

            //check if prior question needs the keyboard
            if arrayOfReviewQuestionTypes[indexOfCurrentReviewPage-1] != "TEXTENTRY" {
                hideKeyboard()
            }
            
            //go to the prior question
            withAnimation(.linear(duration: 0.15)) {
                indexOfCurrentReviewPage -= 1
            }

            print(arrayOfReviewAnswers)
            print(indexOfCurrentReviewPage)
            
            //reset the text for the answer for the next question
            answerForThisQuestion = arrayOfReviewAnswers[indexOfCurrentReviewPage]
            
            print("AND NOW IT IS \(indexOfCurrentReviewPage)")
            
        } label: {
            Image(systemName: "chevron.left")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 48, height: 48)
                .background(RoundedRectangle(cornerRadius: 12).foregroundColor(Color("ReviewTeal")))
        }
    }
}






struct ReviewPageAllButtons_Previews: PreviewProvider {
    static var previews: some View {
        ReviewPageAllButtons()
    }
}
