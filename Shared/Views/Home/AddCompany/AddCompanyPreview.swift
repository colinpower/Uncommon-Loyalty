//
//  AddCompanyPreview.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 7/19/22.
//

import SwiftUI

struct AddCompanyPreview: View {
    
    @Binding var isAddCompanyPreviewActive : Bool
    @State private var companies = ["Company A", "Company B"]
    
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
                            AddCompanyWidget(backgroundImage: "Skincare Background", companyLogo: "Athleisure LA", company: "Athleisure LA", joiningBonus: "15% on new purchases", color: Color("Background"))
                            
                        }//.padding(.top, 120)
                    }
                }
            }.ignoresSafeArea()
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        
//            .onAppear {
//                self.viewModel1.listenForMyRewardsPrograms(email: Auth.auth().currentUser?.email ?? "")
//                print("CURRENT USER IS")
//                print(Auth.auth().currentUser?.email ?? "")
//                print(self.viewModel1.myRewardsPrograms)
//            }
//            .onDisappear {
//                print("DISAPPEAR")
//                if self.viewModel1.listener1 != nil {
//                    print("REMOVING LISTENER")
//                    self.viewModel1.listener1.remove()
//                }
//            }
        
    }
}

struct AddCompanyPreview_Previews: PreviewProvider {
    static var previews: some View {
        AddCompanyPreview(isAddCompanyPreviewActive: .constant(true))
    }
}
