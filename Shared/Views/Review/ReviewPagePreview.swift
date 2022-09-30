//
//  ReviewPagePreview.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/2/22.
//

import SwiftUI

struct ReviewPagePreview: View {
    
    //Environment
    
    //ViewModels
    @ObservedObject var itemsViewModel = ItemsViewModel()
    @ObservedObject var reviewsViewModel = ReviewsViewModel()
    
    //State
    @State var answerForThisQuestion:String = ""
    @State var rating : Int = 0
    
    @State var allowedToDisplayProfilePic:Bool = true
    @State var allowedToDisplayName:Bool = true
    
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
    
    @Binding var isShowingReviewExperience:Bool
    
    var item: Items
    
    var userID: String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            
            VStack(alignment: .center) {
                let reviewTimestamp = Int(round(Date().timeIntervalSince1970))
                
                ReviewCard(reviewerProfilePic: "Athleisure LA", reviewerFirstName: "Colin", reviewerLastName: "Power", reviewTimestamp: reviewTimestamp, reviewRating: overallRatingForReview, reviewTitle: arrayOfReviewAnswers[2], reviewBody: arrayOfReviewAnswers[1])
                    .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white))
                    .clipShape(RoundedRectangle(cornerRadius: 11))
                    .shadow(radius: 5)
                    .padding()
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    Text("DISPLAY PREFERENCES")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color("Gray1"))
                        .padding(.leading)
                        .padding(.bottom, 4)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        HStack(alignment: .center, spacing: 0) {
                            
                            Toggle(isOn: $allowedToDisplayProfilePic) {
                                Text("Show my profile picture")
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(Color("Dark1"))
                            }
                        }
                        
                        Divider().padding(.vertical, 8)
                        
                        HStack(alignment: .center, spacing: 0) {
                            
                            Toggle(isOn: $allowedToDisplayProfilePic) {
                                Text("Show my name")
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(Color("Dark1"))
                            }
                        }
                        
                        
                        
                    }.padding(.horizontal)
                    .padding(.vertical, 12)
                    .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white))
                    
                }.padding()
                
            }.frame(height: 460)

            Spacer()
            
            
            //MARK: SUBMIT BUTTON
            Button {
                
                itemsViewModel.updateItemForReview(item: item, userID: userID, rating: overallRatingForReview)
                    
//                reviewsViewModel.addReview(companyID: item.ids.companyID, email: item.order.email, itemID: item.ids.itemID, orderID: item.ids.orderID, reviewRating: overallRatingForReview, questionsArray: arrayOfReviewQuestions, responsesArray: arrayOfReviewAnswers, reviewTitle: arrayOfReviewAnswers[1], userID: item.ids.userID)
                
                reviewsViewModel.addReview(firstName: "COLIN", lastName: "POWER", itemName: item.order.title, companyName: item.order.companyName, companyLogo: item.ids.companyID, profilePic: "NONE", reviewRating: overallRatingForReview, questionsArray: arrayOfReviewQuestions, responsesArray: arrayOfReviewAnswers, allowedToDisplayProfilePic: allowedToDisplayProfilePic, allowedToDisplayName: allowedToDisplayName, companyID: item.ids.companyID, email: item.order.email, itemID: item.ids.itemID, orderID: item.ids.orderID, reviewTitle: arrayOfReviewAnswers[1], userID: item.ids.userID, rewardEarned: 1994)
                
                isShowingReviewExperience.toggle()
                
            } label: {
                
                HStack {
                    Spacer()
                    Text("Submit review")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.vertical, 20)
                    Spacer()
                }
                .background(RoundedRectangle(cornerRadius: 12).foregroundColor(Color("ReviewTeal")))
                .padding(.horizontal).padding(.horizontal)
                .padding(.bottom, 100)
            }
            
        }
        .ignoresSafeArea()
        .frame(width: screenWidth, height: UIScreen.main.bounds.height-260)
        .onAppear {
            print("We're on page \(indexOfCurrentReviewPage)")
            //print(reviewQuestionForThisPage)
        }
        
        
        
        
    }
}

//struct ReviewPagePreview_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewPagePreview()
//    }
//}
