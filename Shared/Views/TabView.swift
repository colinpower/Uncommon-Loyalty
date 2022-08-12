//
//  TabView.swift
//  Uncommon Loyalty
//
//  Created by Colin Power on 7/27/22.
//

import SwiftUI

struct MyTabView: View {
    
    @Binding var selectedTab: Int
    
    var body: some View {
            
            HStack {
                Spacer()
                Button {
                    selectedTab = 1
                } label: {
                    Image(systemName: "house.fill")
                        .foregroundColor(selectedTab==1 ? .gray : .black)
                        .font(.system(size: 30))
                }
                Spacer()
                Button {
                    selectedTab = 2
                } label: {
                    Image(systemName: "newspaper")
                        .foregroundColor(selectedTab==2 ? .gray : .black)
                        .font(.system(size: 30))
                }
                Spacer()
                Button {
                    selectedTab = 3
                } label: {
                    Image(systemName: "person.fill")
                        .foregroundColor(selectedTab==3 ? .gray : .black)
                        .font(.system(size: 30))
                }
                Spacer()
            }.padding(.vertical)
            .padding(.bottom)
    }
}

struct MyTabView_Previews: PreviewProvider {
    static var previews: some View {
        MyTabView(selectedTab: .constant(1))
    }
}
