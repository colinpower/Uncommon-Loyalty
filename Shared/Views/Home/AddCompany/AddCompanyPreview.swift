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

    @Binding var isAddCompanyPreviewActive : Bool
    
    
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .top) {
                    
                    //MARK: Background color
                    Color("Background")
                    
                    //the content on top of the background
                    VStack {
                        SheetHeader(title: "Join Loyalty Programs", isActive: $isAddCompanyPreviewActive)
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            
                            ForEach(viewModel_companies.myCompanies) { Company in

                                
                                NavigationLink(destination: AddCompany(companyID: Company.companyID, companyName: Company.companyName, joiningBonus: Company.joiningBonus, website: Company.website)
                                    .navigationBarTitle("", displayMode: .inline)) {
                                        AddCompanyWidget(companyID: Company.companyID, companyName: Company.companyName, joiningBonus: Company.joiningBonus, color: Color("Skincare"), website: Company.website)
                                    }
                            }
                            
                            
                        }
                    }
                }
            }.ignoresSafeArea()
            .navigationTitle("")
            .navigationBarHidden(true)
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
}

//struct AddCompanyPreview_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCompanyPreview(isAddCompanyPreviewActive: .constant(true))
//    }
//}





//                            AddCompanyWidget(backgroundImage: "Makeup Background", companyLogo: "Makeup Icon", company: "Make Me Glitter Now", joiningBonus: "15% on new purchases", color: Color("Makeup"))


//                            AddCompanyWidget(backgroundImage: "Makeup Background", companyLogo: "Makeup Icon", company: "Make Me Glitter Now", joiningBonus: "15% on new purchases", color: Color("Makeup"))
//                            AddCompanyWidget(backgroundImage: "Facewash Background", companyLogo: "Facewash Icon", company: "FRE Skincare", joiningBonus: "20% on new purchases", color: Color("Facewash"))
//                            AddCompanyWidget(backgroundImage: "Yoga Background", companyLogo: "Yoga Icon", company: "PEACE", joiningBonus: "10% on new purchases", color: Color("Yoga"))
