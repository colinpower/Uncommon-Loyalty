//
//  ReferCarouselButtons.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/4/22.
//

import SwiftUI

struct ReferCarouselButtons: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ReferCarouselNextButton: View {
    
    @State private var wasNextButtonTapped:Bool = false
    
    @Binding var indexOfCurrentReferPage: Int
    
    var selectedContact:[String]
    
    
    
    var body: some View {
        
        Button {
            //flash the rating stars rapidly
            withAnimation(.easeInOut(duration: 0.1).repeatCount(3, autoreverses: true)) {
                wasNextButtonTapped.toggle()
            }
            
            //reset the flashing
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                wasNextButtonTapped = false
            }
            
            //zoom to the next question
            withAnimation(.linear(duration: 0.15).delay(0.55)) {
                indexOfCurrentReferPage += 1
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
            .background(RoundedRectangle(cornerRadius: 12)
                .foregroundColor(selectedContact[1] != "" ? Color("ReferPurple") : .gray)
                .opacity(wasNextButtonTapped ? 0 : 1))
        }.disabled(selectedContact[1] == "")
    }
}

struct ReferCarouselPreviewButton: View {
    
    @State private var wasPreviewButtonTapped:Bool = false
    
    @Binding var indexOfCurrentReferPage: Int
    
    var selectedContact:[String]
    
    
    
    var body: some View {
        
        Button {
            //flash the rating stars rapidly
            withAnimation(.easeInOut(duration: 0.1).repeatCount(3, autoreverses: true)) {
                wasPreviewButtonTapped.toggle()
            }
            
            //reset the flashing
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                wasPreviewButtonTapped = false
            }
            
            //zoom to the next question
            withAnimation(.linear(duration: 0.15).delay(0.55)) {
                indexOfCurrentReferPage += 1
            }
        } label: {
            HStack (alignment: .center, spacing: 2) {
                Text("Preview")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                Image(systemName: "arrow.right")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(width: 96, height: 48)
            .background(RoundedRectangle(cornerRadius: 12)
                .foregroundColor(selectedContact[1] != "" ? Color("ReferPurple") : .gray)
                .opacity(wasPreviewButtonTapped ? 0 : 1))
        }.disabled(selectedContact[1] == "")
    }
}

struct ReferCarouselBackButton: View {
    
    @State private var wasBackButtonTapped:Bool = false
    
    @Binding var indexOfCurrentReferPage: Int
    
    var selectedContact:[String]
    
    
    
    var body: some View {
        
        Button {
            //flash the rating stars rapidly
            withAnimation(.easeInOut(duration: 0.1).repeatCount(3, autoreverses: true)) {
                wasBackButtonTapped.toggle()
            }
            
            //reset the flashing
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                wasBackButtonTapped = false
            }
            
            //zoom to the next question
            withAnimation(.linear(duration: 0.15).delay(0.55)) {
                indexOfCurrentReferPage -= 1
            }
        } label: {
            Image(systemName: "chevron.left")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 48, height: 48)
                .background(RoundedRectangle(cornerRadius: 12).foregroundColor(Color("ReviewTeal"))
                .opacity(wasBackButtonTapped ? 0 : 1))
        }
    }
}

