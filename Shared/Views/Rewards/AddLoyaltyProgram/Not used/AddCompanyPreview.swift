//
//  AddCompanyPreview.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 7/19/22.
//

import SwiftUI


//need to change this view to just be getting a snapshot

struct AddCompanyPreview: View {
    
    
    @StateObject var viewModel_companies = CompaniesViewModel()

    @State var isAddCompanyCarouselActive : Bool = false
    
    
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                
                
                ForEach(viewModel_companies.myCompanies) { Company in

                    
                    NavigationLink(destination: AddCompany(companyID: Company.companyID, companyName: Company.companyName, joiningBonus: Company.joiningBonus, website: Company.website)
                        ) {
                            AddCompanyWidget(companyID: Company.companyID, companyName: Company.companyName, joiningBonus: Company.joiningBonus, color: Color("Skincare"), website: Company.website)
                        }
                }
                
                
            }
        }
        .ignoresSafeArea()
        .navigationTitle("Add Loyalty Program")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            self.viewModel_companies.listenForMyCompanies()
            //print("CURRENT USER IS")
            //print(Auth.auth().currentUser?.email ?? "")
            print("REAPPEAR")
            print(self.viewModel_companies.myCompanies)
        }
        .onDisappear {
            print("DISAPPEAR")
            if self.viewModel_companies.listener_myCompanies != nil {
                print("REMOVING LISTENER")
                self.viewModel_companies.listener_myCompanies.remove()
            }
        }
    }
}
