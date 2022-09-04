//
//  ContactsView.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/3/22.
//

import SwiftUI

struct ContactsView: View {
    
    @StateObject var contactsVM = ContactsViewModel()
    
    
    @State var searchQuery = ""
    
    //@ObservedObject var filteredContacts = ContactsViewModel().contacts
    
    @State var filteredContacts: [Contact] = []

    
    var body: some View {
        NavigationView {
            
            List {
                
//                Button {
//                    filteredContacts = contactsVM.contacts.filter {
//                        $0.firstName
//                          .localizedCaseInsensitiveContains("Anna")
//                      }
//                } label: {
//
//                    VStack {
//                        Text(filteredContacts.first?.firstName ?? "")
//                    }
//
//                }
                
                if searchQuery != "" {
                    
                    ForEach(contactsVM.contacts.filter { $0.firstName.hasPrefix(searchQuery) || $0.lastName.hasPrefix(searchQuery) }) { contact in
                        
    //                    Text("FROM THE FILTER")
    //                    Text(filteredContacts.first?.firstName ?? "")
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Label(contact.firstName, systemImage: "person.crop.circle")
                                Text(contact.lastName).bold()
                            }
                            Divider()
                            Label(contact.phone ?? "not provided", systemImage: "apps.iphone")
                        }
                        .padding()
                        .background(Color.secondary.opacity(0.25))
                        
                    }

                } else {
                    
                    ForEach(contactsVM.contacts) { contact in
                        
    //                    Text("FROM THE FILTER")
    //                    Text(filteredContacts.first?.firstName ?? "")
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Label(contact.firstName, systemImage: "person.crop.circle")
                                Text(contact.lastName).bold()
                            }
                            Divider()
                            Label(contact.phone ?? "not provided", systemImage: "apps.iphone")
                        }
                        .padding()
                        .background(Color.secondary.opacity(0.25))
                        
                    }
                }
                
                
                    
            }
            .navigationTitle("Contacts")
        }.searchable(text: $searchQuery, prompt: "Search by first name")
//            .onSubmit(of: .search, {
//                filterContacts()
//                })
        .alert(item: $contactsVM.permissionsError) { _ in
            Alert(
                title: Text("Permission denied"),
                message: Text(contactsVM.permissionsError?.description ?? "unknown error"),
                dismissButton:
                    .default(Text("OK"),
                            action: {contactsVM.openSettings() })
            )
        }
    }
//
//    func filterContacts() {
//      if searchQuery.isEmpty {
//        // 1
//        filteredContacts = contactsVM.contacts
//      } else {
//        // 2
//          filteredContacts = contactsVM.contacts.filter {
//          $0.firstName
//            .localizedCaseInsensitiveContains(searchQuery)
//        }
//      }
//    }

    
    
    
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
    }
}
