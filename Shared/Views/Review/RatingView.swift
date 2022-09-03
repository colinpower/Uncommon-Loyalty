//
//  RatingView.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 3/30/22.
//

import SwiftUI

struct RatingView: View {
    
    //State variables
    @State var wasRatingTapped:Bool = false
    
    //Binding
    @Binding var rating: Int
    @Binding var answerForThisQuestion:String
    @Binding var arrayOfReviewAnswers:[String]
    @Binding var runningSumOfEarnedPoints:Double
    @Binding var overallRatingForReview:Int
    @Binding var indexOfCurrentReviewPage:Int
    @Binding var arrayOfReviewQuestions: [String]
    @Binding var arrayOfReviewQuestionTypes:[String]
    
    //Required variables
    var arrayOfEarnablePointsForEachQuestion: [Double]
    var screenWidth:CGFloat
    
    //Required variables for the rating specifically
    var label = ""
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray.opacity(0.3)
    var onColor = Color.yellow
    
    
    var body: some View {
        HStack {
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                returnImage(for: number)
                    .font(.system(size: 36))
                    .foregroundColor(number > rating ? offColor : onColor)
                    .opacity(wasRatingTapped ? 0 : 1)
                    .onTapGesture {
                        
                        //set the new rating
                        rating = number
                        
                        //set the overall rating
                        overallRatingForReview = rating
                        
                        //convert "rating" as INT into "answerForThisQuestion" as STRING
                        answerForThisQuestion = String(rating)
                        
                        //add, subtract, or don't change points depending on whether answer added, removed, or updated
                        withAnimation {
                            runningSumOfEarnedPoints = updatePointsForSubmission(answerForThisQuestion: answerForThisQuestion, arrayOfReviewAnswers: arrayOfReviewAnswers, runningSumOfEarnedPoints: runningSumOfEarnedPoints, arrayOfEarnablePointsForEachQuestion: arrayOfEarnablePointsForEachQuestion, indexOfCurrentReviewPage: indexOfCurrentReviewPage)
                        }
                        
                        //update the answer in the results array
                        arrayOfReviewAnswers[indexOfCurrentReviewPage] = answerForThisQuestion
                        
                        //flash the rating stars rapidly
                        withAnimation(.easeInOut(duration: 0.1).repeatCount(3, autoreverses: true)) {
                            wasRatingTapped.toggle()
                        }
                        
                        //reset the flashing
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                            wasRatingTapped = false
                        }
                        
                        //zoom to the next question
                        withAnimation(.linear(duration: 0.15).delay(0.55)) {
                            indexOfCurrentReviewPage += 1
                        }
                        
                        //reset the text for the answer for the next question
                        answerForThisQuestion = arrayOfReviewAnswers[indexOfCurrentReviewPage]
                        
                        
                    }
            }
        }
        .ignoresSafeArea()
    }
    
    func returnImage(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

//struct RatingView_Previews: PreviewProvider {
//    static var previews: some View {
//        RatingView(rating: .constant(4))
//    }
//}
