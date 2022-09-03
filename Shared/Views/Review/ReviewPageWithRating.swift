//
//  ReviewPageWithRating.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/2/22.
//

import SwiftUI

struct ReviewPageWithRating: View {
    
    //Environment
    
    //ViewModels
    
    //State
    @State var answerForThisQuestion:String = ""
    @State var rating : Int = 0
    
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
            
            //MARK: QUESTION
            Text(arrayOfReviewQuestions[indexOfCurrentReviewPage])
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.leading)
                .foregroundColor(Color("Dark1"))
                .padding(.top, 60)
                .padding(.bottom, 20)
                .padding(.horizontal)
                .frame(height: 140, alignment: .leading)
            
            //MARK: RATING VIEW
            RatingView(rating: $rating, answerForThisQuestion: $answerForThisQuestion, arrayOfReviewAnswers: $arrayOfReviewAnswers, runningSumOfEarnedPoints: $runningSumOfEarnedPoints, overallRatingForReview: $overallRatingForReview, indexOfCurrentReviewPage: $indexOfCurrentReviewPage, arrayOfReviewQuestions: $arrayOfReviewQuestions, arrayOfReviewQuestionTypes: $arrayOfReviewQuestionTypes, arrayOfEarnablePointsForEachQuestion: arrayOfEarnablePointsForEachQuestion, screenWidth: screenWidth)
                .padding(.vertical, 20)
                .padding(.horizontal)
                .frame(height: 80, alignment: .center)
            
            //MARK: BUTTONS
            HStack(alignment: .center) {
                
                //MARK: BACK BUTTON
                //Don't show the Back button on the first page
                if indexOfCurrentReviewPage != 0 {
                    Button {
                        //go to the prior question
                        withAnimation(.linear(duration: 0.15)) {
                            indexOfCurrentReviewPage -= 1
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24, weight: .bold))
                            .frame(width: 48, height: 48)
                            .background(RoundedRectangle(cornerRadius: 12).foregroundColor(Color("ReviewTeal")))
                    }
                } else {
                    Rectangle().foregroundColor(.clear).frame(width: 48, height: 48)
                }
                
                Spacer()
                
                //MARK: NEXT BUTTON
                //Don't show the NEXT button on the final page
                if ((indexOfCurrentReviewPage + 1) != arrayOfReviewQuestionTypes.filter({ $0 != "" }).count) {
                    Button {
                        //go to the prior question
                        withAnimation(.linear(duration: 0.15)) {
                            indexOfCurrentReviewPage += 1
                        }
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
                } else {
                    Button {
                        //go to the next question
                        withAnimation(.linear(duration: 0.15)) {
                            indexOfCurrentReviewPage += 1
                        }
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
                .padding(.top, 20)
                .padding(.horizontal)
                .frame(height: 70, alignment: .center)
            
            Spacer()
            
        }.ignoresSafeArea()
        .frame(width: screenWidth, height: UIScreen.main.bounds.height-260)
        .onAppear {
            print("We're on page \(indexOfCurrentReviewPage)")
            //print(reviewQuestionForThisPage)
        }
    }
}

