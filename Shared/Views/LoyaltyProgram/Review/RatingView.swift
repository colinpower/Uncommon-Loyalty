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
                    .font(.title)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                        withAnimation(.linear(duration: 0.15)) {
                            horizontalOffset -= width
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
