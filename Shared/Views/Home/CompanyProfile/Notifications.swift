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
    
    
    @State private var news_email = false
    
    @Binding var isNotificationsActive:Bool
    
    var body: some View {

                //the content on top of the background
                VStack(alignment: .leading) {
                    
                    //MARK: Header
                    SheetHeader(title: "Notifications", isActive: $isNotificationsActive)
                    Spacer()
                    Text("asldfkjasldfkj")
                    List {
                        Section {
                            VStack {
                                Toggle("123", isOn: $news_email)
                                Toggle("123", isOn: $news_email)
                                Toggle("123", isOn: $news_email)
                            }
                        } header: {
                            Text("NEWS")
                        }
                        Section {
                            VStack {
                                Toggle("123", isOn: $news_email)
                                Toggle("123", isOn: $news_email)
                                Toggle("123", isOn: $news_email)
                            }
                        } header: {
                            Text("MORE")
                        }
                        Section {
                            VStack {
                                Toggle("123", isOn: $news_email)
                                Toggle("123", isOn: $news_email)
                                Toggle("123", isOn: $news_email)
                            }
                        } header: {
                            Text("ANOTHER")
                        }
                        
                        Section {
                            VStack {
                                Toggle("123", isOn: $news_email)
                                Toggle("123", isOn: $news_email)
                                Toggle("123", isOn: $news_email)
                            }
                        } header: {
                            Text("FINAL ONE")
                        }

                    }
//                    ScrollView(.vertical, showsIndicators: false) {
//
//
//
//                    }
                    //Spacer()
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
