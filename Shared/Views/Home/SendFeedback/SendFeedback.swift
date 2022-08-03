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
                    HStack (alignment: .center) {
                        Text("Send Feedback")
                            .font(.system(size: 24))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Dark1"))
                        Spacer()
                        Button {
                            isSendFeedbackActive.toggle()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(Color("Dark1"))
                                .font(Font.system(size: 20, weight: .semibold))
                        }
                    }.padding(.top, 48)
                    .padding()
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
