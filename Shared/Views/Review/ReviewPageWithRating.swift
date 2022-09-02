////
////  ReviewPageWithRating.swift
////  Uncommon Loyalty (iOS)
////
////  Created by Colin Power on 9/2/22.
////
//
//import SwiftUI
//
//struct ReviewPageWithRating: View {
//    
//    @Binding var pointsEarned:Double
//    
//    var screenWidth:CGFloat
//    
//    var index:Int
//    
//    @Binding var resultingArray:[String]
//    
//    @Binding var currentQuestion:Int
//    
//    @State var rating:Int = 0
//    
//    
//    var body: some View {
//        Button {
//            
//            rating = index
//            
//            pointsEarned = updatePointsForSubmission(answers: resultingArray, newAnswer: String(index*100), index: index, currentPoints: pointsEarned, pointsForThisQuestion: Double(100))
//            
//            //update the answer in the results array
//            resultingArray[index] = String(rating*100)
//            
//            //go to the next question
//            currentQuestion += 1
//            
//            print(resultingArray)
//        } label: {
//            VStack {
//                Text("Add points")
//                Text("On index \(index)")
//            }
//            
//            Button {
//                pointsEarned = updatePointsForSubmission(answers: resultingArray, newAnswer: String(index*100), index: index, currentPoints: pointsEarned, pointsForThisQuestion: Double(100))
//                
//                //update the answer in the results array
//                resultingArray[index] = String(rating*100)
//                
//                //go to the next question
//                currentQuestion += 1
//                
//            } label: {
//                Text("Next")
//            }
//            
//            Button {
//                pointsEarned = updatePointsForSubmission(answers: resultingArray, newAnswer: String(index*100), index: index, currentPoints: pointsEarned, pointsForThisQuestion: Double(100))
//                
//                //update the answer in the results array
//                resultingArray[index] = String(rating*100)
//                
//                //go to the prior question
//                currentQuestion -= 1
//            } label: {
//                Text("Back")
//            }
//            
//            
//        }.frame(width: screenWidth, height: 300).background(.yellow)
//    }
//}
//
////struct ReviewPageWithRating_Previews: PreviewProvider {
////    static var previews: some View {
////        ReviewPageWithRating()
////    }
////}
