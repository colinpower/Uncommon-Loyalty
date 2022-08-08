//
//  Notifications.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/8/22.
//

import SwiftUI

struct Notifications: View {
    
    
    var companyID: String
    var email: String
    
    @Binding var isNotificationsActive:Bool
    
    var body: some View {
        GeometryReader { geometry in
                        
            ZStack(alignment: .top) {
                
                //MARK: Background color
                Color("Background")
                
                //the content on top of the background
                VStack(alignment: .leading) {
                    
                    //MARK: Header
                    SheetHeader(title: "Notifications", isActive: $isNotificationsActive)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        List {
                            Section {
                                HStack {
                                    Text("123")
                                    Spacer()
                                    Text("123")
                                }
                            } header: {
                                Text("NEWS")
                            }

                        }
                            
                    }
                }
            }
        }.ignoresSafeArea()
//        .onAppear {
//            self.viewModel3.listenForMyTransactions(email: "colinjpower1@gmail.com", companyID: companyID)
//        }
    }
}


struct Notifications_Previews: PreviewProvider {
    static var previews: some View {
        Notifications(companyID: "zKL7SQ0jRP8351a0NnHM",  email: "colinjpower1@gmail.com", isNotificationsActive: .constant(true))
    }
}
