//
//  Discover.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/24/22.
//

import SwiftUI

struct Discover: View {
    
    @Binding var selectedTab:Int
    @State var isProfileActive:Bool = false
    
    @State var isShowingDetailView = false
    
    @State var tempItemID:String = "123tempITEMID"
    
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                //MARK: POLL WIDGET
                
                NavigationLink {
                    Poll(tempItemID: $tempItemID, selectedTab: $selectedTab)
                } label: {
                    VStack {
                        //Header
                        HStack{
                            Image("Athleisure LA")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40, alignment: .center)
                                .padding(.trailing, 12)
                                .padding(.vertical, 3)
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Athleisure LA")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(Color("Dark1"))
                                Text("Timestamp")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(Color("Dark1"))
                            }.padding(.vertical, 6)
                            Spacer()
                            Text("Gold Members")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Color("Dark1"))
                                .padding(.horizontal)
                                .padding(.vertical, 4)
                                .background(.blue)
                                .padding(.vertical, 12)
                        }.padding(.horizontal)
                            .background(Rectangle()
                                .frame(width: UIScreen.main.bounds.width, height: 46)
                                .foregroundColor(Color("Background")))
                        
                        //Content (TABVIEW)
                        HStack(alignment: .center) {
                            Spacer()
                            Image("redshorts")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150, alignment: .center)
                                .padding(.trailing, 12)
                            Spacer()
                        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                        
                        //Footer
                        HStack(alignment: .top) {
                            Text("Jenny (Athleisure LA): We're thinking about releasing a new line of swim trunks next year.. what do you all think?")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Color("Dark1"))
                                .multilineTextAlignment(.leading)
                                .frame(width: UIScreen.main.bounds.width * 3 / 4, height: 60, alignment: .leading)
                            Image(systemName: "circle.fill")
                                .font(.system(size: 12))
                                .padding(.trailing, 6)
                            Image(systemName: "circle.fill")
                                .font(.system(size: 12))
                        }.padding(.horizontal)
                            .background(Rectangle()
                                .frame(width: UIScreen.main.bounds.width, height: 30)
                                .foregroundColor(Color("Background")))
                    }
                        
                }
                
                
                Spacer()
                MyTabView(selectedTab: $selectedTab)
            }
            .background(.white)
            .edgesIgnoringSafeArea([.bottom, .horizontal])
            .navigationTitle("Discover").font(.title)
            .onAppear {
                // stuff goes here
            }

        }
    }
}

struct Discover_Previews: PreviewProvider {
    static var previews: some View {
        Discover(selectedTab: .constant(2))
    }
}
