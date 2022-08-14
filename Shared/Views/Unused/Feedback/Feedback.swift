//
//  Feedback.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 4/24/22.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseStorage

struct Feedback: View {
    
    @State var url = ""
    
    var body: some View {
        VStack {
            Text("feedback page")
            FeedbackCard()
            
            
        
//            if url != "" {
//                WebImage(url: URL(string: url)!)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 50, height: 50)
//                    .clipped()
//                    .cornerRadius(50)
//            }
//        }.onAppear {
//            let storage = Storage.storage().reference()
//            storage.child("AthleisureLA.png").downloadURL { (url, err) in
//                if err != nil {
//                    print(err?.localizedDescription)
//                    return
//                } else {
//                    self.url = "\(url!)"
//                }
//            }
        }
    }
}

struct Feedback_Previews: PreviewProvider {
    static var previews: some View {
        Feedback()
    }
}


struct FeedbackCard: View {
    
    var body: some View {
        Text("here")
        
    }
    
}
