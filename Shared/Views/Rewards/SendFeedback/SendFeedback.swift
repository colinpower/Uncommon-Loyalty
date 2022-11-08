//
//  SendFeedback.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/2/22.
//

import SwiftUI

struct SendFeedback: View {
    
    @Binding var isSendFeedbackActive:Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("Background")
            
            VStack {
                VStack(alignment: .leading) {
                    //Header
                    SheetHeader(title: "Send Feedback", isActive: $isSendFeedbackActive)
                    
                }
                Spacer()
                VStack {
                    Text("what can we improve?")
                }
                Spacer()
            }
        }.ignoresSafeArea()
    }
}

struct SendFeedback_Previews: PreviewProvider {
    static var previews: some View {
        SendFeedback(isSendFeedbackActive: .constant(true))
    }
}
