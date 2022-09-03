//
//  ContactsViewModel.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/3/22.
//

import Foundation
import UIKit
import Contacts


final class ContactsViewModel: ObservableObject {
    
    @Published
    var contacts: [Contact] = []
    
    @Published
    var permissionsError: PermissionsError? = .none
    
    init() {
        permissions()
    }
    
    func openSettings() {
        permissionsError = .none
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsURL) { UIApplication.shared.open(settingsURL) }
    }
    
    private func getContacts() {
        Contact.fetchAll { [weak self ] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let fetchedContacts):
                DispatchQueue.main.async {
                    self.contacts = fetchedContacts.sorted(by: { $0.lastName < $1.lastName })
                }
            case .failure(let error):
                self.permissionsError = .fetchError(error)
            }
        }
        
        
    }
    private func permissions() {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            getContacts()
        case .notDetermined, .restricted, .denied:
            CNContactStore().requestAccess(for: .contacts) { [weak self] granted, error in
                
                guard let self = self else { return }
                switch granted {
                case true:
                    self.getContacts()
                case false:
                    DispatchQueue.main.async {
                        self.permissionsError = .userError
                    }
                }
            }
        default:
            fatalError("Unknown Error")
        }
    }
}
