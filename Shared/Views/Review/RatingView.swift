//
//  RatingView.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 3/30/22.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    var width: CGFloat
    @Binding var horizontalOffset: CGFloat
    
    @Binding var questionsArray: [String]
    @Binding var answersArray: [String]
    
    @Binding var responses: [String]
    @Binding var currentQuestion: Int
    
    @Binding var pointsEarned: Double
    
    var label = ""
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray.opacity(0.3)
    var onColor = Color.yellow
    
    @State var wasRatingTapped:Bool = false
    
    var body: some View {
        HStack {
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                returnImage(for: number)
                    .font(.title)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .opacity(wasRatingTapped ? 0 : 1)
                    .onTapGesture {
                        if rating == 0 {        //i.e. it's the first time the user has seen this page
                            withAnimation {
                                pointsEarned = pointsEarned + 100
                            }
                        }

                        rating = number
                        questionsArray[0] = ("rating")
                        answersArray[0] = (String(rating))
                        responses[currentQuestion] = String(rating)
                        
                        print(currentQuestion)
                        
                        
                        currentQuestion += 1
                        
                        
                        print(currentQuestion)
                        
                        withAnimation(.linear(duration: 0.15).delay(0.55)) {
                            horizontalOffset -= width
                        }
                        withAnimation(.easeInOut(duration: 0.1).repeatCount(3, autoreverses: true)) {
                            wasRatingTapped.toggle()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                            wasRatingTapped = false
                        }
                        
                        
                    }
            }
        }
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
