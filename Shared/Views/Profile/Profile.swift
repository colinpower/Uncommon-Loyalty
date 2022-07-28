//
//  Profile.swift
//  Uncommon Loyalty
//
//  Created by Colin Power on 4/4/22.
//

import SwiftUI

struct Profile: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @Binding var selectedTab: Int
    
    
    var body: some View {
        VStack {
            Button(action: {
                viewModel.signOut() }, label: {
                    Text("Sign out")
                        .frame(width: 200, height: 200, alignment: .center)
                        .background(.green)
                        .foregroundColor(.white)
                })
            TabView(selectedTab: $selectedTab)
        }
        
//        }.navigationTitle("")
//            .navigationBarHidden(true)
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile(selectedTab: .constant(3))
    }
}
