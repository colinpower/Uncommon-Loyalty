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
    
    @State var hasConsentToPost:Bool = false
    @State var isNameHidden:Bool = false
    
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
            
            List {
                
                //MARK: PREVIEW OF REVIEW SECTION
                Section {
                    
                    //preview of review
                    HStack(alignment: .center) {
                        
                        //image
                        Image("redshorts")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4)
                            .cornerRadius(32)
                            .padding(.trailing).padding(.trailing)
                        
                        //empty review
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Joggers 2.0")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.black)
                                .padding(.bottom, 4)
                            
                            Text("Absolutely amazing! I can't wait to get another pair")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .padding(.bottom)
                            
                            HStack(alignment: .center) {
                                Image(systemName: "star.fill")
                                Image(systemName: "star.fill")
                                Image(systemName: "star.fill")
                                Image(systemName: "star.fill")
                                Image(systemName: "star.fill")
                            }.font(.system(size: 18))
                            .foregroundColor(Color.yellow)

                        }
                    }
                    HStack {
                        if isNameHidden {
                            Spacer()
                            Label {
                                Text("Verified Buyer")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.green)
                            } icon: {
                                Image(systemName: "checkmark.seal.fill")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.green)
                            }.foregroundColor(.green)

                        } else {
                            Text("Colin P.")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color("Dark1"))
                            Spacer()
                            Label {
                                Text("Verified Buyer")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.green)
                            } icon: {
                                Image(systemName: "checkmark.seal.fill")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.green)
                            }.foregroundColor(.green)
                            
                        }
                    }
                    
                }
                
                //MARK: ADDITIONAL DETAILS SECTION
                
                
                //MARK: HIDE NAME
                Section {
                    HStack {
                        Text("Hide my name")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color("Dark1"))
                        Spacer()
                        Toggle(isOn: $isNameHidden) {
                            Text("")
                        }
                    }
                }
                
                //MARK: CONSENT
                Section(header: Text("Consent")) {
                    HStack {
                        Text("Can we post this review?")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color("Dark1"))
                        Spacer()
                        Button {
                            hasConsentToPost.toggle()
                        } label: {
                            if hasConsentToPost {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundColor(Color("ReviewTeal"))
                            } else {
                                Image(systemName: "checkmark.circle")
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundColor(Color("ReviewTeal"))
                            }
                            
                            
                        }
                        
                    }
                }
                
            }.frame(height: 460)
            
            Spacer()
            
            
            //MARK: SUBMIT BUTTON
            Button {
                
                itemsViewModel.updateItemForReview(userID: item.userID, itemID: item.itemID, rating: overallRatingForReview)
                
                reviewsViewModel.addReview(companyID: item.companyID, email: item.email, itemID: item.itemID, reviewRating: overallRatingForReview, questionsArray: arrayOfReviewQuestions, responsesArray: arrayOfReviewAnswers, reviewTitle: arrayOfReviewAnswers[1], userID: item.userID)
                
                isShowingReviewExperience.toggle()
                
            } label: {
                
                if hasConsentToPost {
                    HStack {
                        Spacer()
                        Text("Submit")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.vertical)
                        Spacer()
                    }
                    .background(RoundedRectangle(cornerRadius: 12).foregroundColor(Color("ReviewTeal")))
                    .padding(.horizontal)

                } else {
                    HStack {
                        Spacer()
                        Text("Submit")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.vertical)
                        Spacer()
                    }
                    .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.gray))
                    .padding(.horizontal)
                    
                }
            }.disabled(!hasConsentToPost)
                .padding(.bottom, 60)
        
            
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
