//
//  CheckYourEmail.swift
//  Uncommon Loyalty
//
//  Created by Colin Power on 8/11/22.
//

import SwiftUI

struct CheckYourEmail: View {
    
    @Binding var isShowingCheckEmailView: Bool
    
    
    var body: some View {
        ZStack {
        Color("bg")
        
        VStack(alignment: .leading) {
            HStack {
                Button {
                    isShowingCheckEmailView.toggle()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(Font.system(size: 40, weight: .semibold))
                        .foregroundColor(.white)
                }
                Spacer()
            }.padding(.top, 80)
            
            Spacer()
            VStack(alignment: .leading, spacing: 0) {
                Text("Check your email")
                    .foregroundColor(Color("ThemeLight"))
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                Text("We sent you a sign-in link.")
                    .foregroundColor(Color("ThemeLight"))
                    .font(.system(size: 18))
                    .fontWeight(.regular)
            }
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            HStack {
                Spacer()
                Text("(It might be in your Spam folder... sorry)")
                    .foregroundColor(Color("ThemeLight"))
                    .font(.system(size: 13))
                    .fontWeight(.regular)
                Spacer()
            }
            Spacer()
        }.padding(.horizontal).padding(.horizontal)
    }.edgesIgnoringSafeArea(.all)
    }
}

struct CheckYourEmail_Previews: PreviewProvider {
    static var previews: some View {
        CheckYourEmail(isShowingCheckEmailView: .constant(true))
    }
}
