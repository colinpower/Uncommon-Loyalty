//
//  AddLoyaltyProgramPreview.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/6/22.
//

import SwiftUI


//need to change this view to just be getting a snapshot

struct AddLoyaltyProgramPreview: View {
    
    @StateObject var viewModel_companies = CompaniesViewModel()

    @State var isAddLoyaltyProgramCarouselActive : Bool = false
    
    var company: Companies
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            
            ZStack(alignment: .top) {
                Image("BlueGoldenRatio")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.6)
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    Spacer()
                    
                    HStack(alignment: .bottom, spacing: 0) {
                        Image("Athleisure LA")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .cornerRadius(8)
                            .padding(.trailing)
                        Text("Athleisure LA")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                    }.padding([.leading, .bottom])
                }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.6)
                    .layoutPriority(-1)
            
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.6)
                .padding(.bottom)
                .padding(.bottom)
            
            //MARK: ABOUT US SECTION
            VStack(spacing: 0) {
                HStack {
                    Text("About Us")
                        .foregroundColor(Color("Dark1"))
                        .font(.system(size: 20, weight: .bold))
                    Spacer()
                }.padding(.bottom)
                
                HStack {
                    Text("We make very high quality products for all your athletic needs")
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color("Dark1"))
                        .font(.system(size: 16, weight: .medium))
                }.frame(width: UIScreen.main.bounds.width)
            }
                .padding(.horizontal)
                .padding(.bottom, 30)
            
            //MARK: MOST POPULAR SECTION
            VStack(alignment: .leading, spacing: 0) {
                
                Text("We're known for these products")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color("Dark1"))
                    .font(.system(size: 20, weight: .bold))
                    .padding(.horizontal)
            
                AddLoyaltyProgramPopularItemsTabView()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 3 / 4)
            }
            .padding(.bottom, 60)
            
            
            
            
            Spacer()
            
            
            Button(action: {
                isAddLoyaltyProgramCarouselActive = true
            }) {
               HStack {
                   Spacer()
                   Text("Join & get 20%!")
                       .foregroundColor(Color.white)
                       .font(.system(size: 18))
                       .fontWeight(.semibold)
                       .padding(.vertical, 16)
                   Spacer()
               }.background(RoundedRectangle(cornerRadius: 36).fill(Color("ReferPurple")))
                .padding(.horizontal)
                .padding(.horizontal)
                .padding(.bottom, 60)
            }.fullScreenCover(isPresented: $isAddLoyaltyProgramCarouselActive) {
                //on dismiss....
                
            } content: {
                AddLoyaltyProgramCarousel(isAddLoyaltyProgramCarouselActive: $isAddLoyaltyProgramCarouselActive)
            }
            
        }
        .ignoresSafeArea()
        .background(Color("Background"))
        .navigationTitle("")
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
    
    
    var RecommendedItem: some View {
        HStack {
            Spacer()
            VStack(alignment: .center, spacing: 0) {
                Text("ABC Shorts")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.top, 24)
                    .padding(.bottom, 2)
                HStack(alignment: .center, spacing: 6) {
                    Text("Normally $99").strikethrough()
                        .foregroundColor(.gray)
                        .font(.system(size: 15, weight: .regular))
                    Text("$79 after discount")
                        .foregroundColor(.gray)
                        .font(.system(size: 15, weight: .regular))
                }
                Spacer()
                Image("redshorts")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4)
                Spacer()
                Button {
                    //copy
                } label: {
                    HStack {
                        Spacer()
                        Text("View on website").font(.system(size: 16, weight: .semibold)).padding(.vertical)
                        Spacer()
                    }.background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
                }.padding(.horizontal).padding(.bottom)
                
            }
                
                
            Spacer()
        }.background(.white)
        
        
        
        
    }
    
}
