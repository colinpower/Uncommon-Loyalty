//
//  ContactsView.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/3/22.
//

import SwiftUI

struct ContactsView: View {
    
    @StateObject
    private var contactsVM = ContactsViewModel()
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(contactsVM.contacts) { contact in
                    
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
                    
                }.navigationTitle("Contacts")
            }.alert(item: $contactsVM.permissionsError) { _ in
                Alert(
                    title: Text("Permission denied"),
                    message: Text(contactsVM.permissionsError?.description ?? "unknown error"),
                    dismissButton:
                        .default(Text("OK"),
                                action: {contactsVM.openSettings() })
                )
            }
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
    }
}
