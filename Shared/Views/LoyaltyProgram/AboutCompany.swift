//
//  AboutCompany.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/2/22.
//

import SwiftUI

struct AboutCompany: View {
    
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
//            ZStack(alignment: .top) {
//                Image("BlueGoldenRatio")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.width / 1.6)
//                    .layoutPriority(-1)
//                Rectangle()
//                    .foregroundColor(.clear)
//                    .background(LinearGradient(gradient: Gradient(colors: [.clear, .red.opacity(0.4)]), startPoint: .top, endPoint: .bottom))
//                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.width / 1.6)
//            }.padding(.horizontal)
//                .shadow(color: .gray, radius: 10, x: 0, y: 0)
            
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
            
            
            //MARK: BUTTONS
            HStack(spacing: 12) {
                Button {
                    //copy
                } label: {
                    HStack {
                        Spacer()
                        Text("Contact").font(.system(size: 18, weight: .semibold)).foregroundColor(.black).padding(.vertical)
                        Spacer()
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width / 2)
                    .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.white))
                }
                
                Link(destination: URL(string: "https://www.google.com")!) {
                    HStack {
                        Spacer()
                        Text("Visit website").font(.system(size: 18, weight: .semibold)).foregroundColor(.black).padding(.vertical)
                        Spacer()
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width / 2)
                    .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.white))
                }
                
            }.padding(.horizontal)
                .padding(.bottom)
            
            //MARK: CONTENT
            List {
                
                //MARK: POINTS, TIME, QUESTIONS
                Section(header: Text("Return policy")) {
                    
                    HStack {

                        Text("Return window")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            
                        Spacer()
                        
                        Text("30 days")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                        

                    }
                    
                    NavigationLink {
                        //
                    } label: {
                        HStack {

                            Text("Full return policy")
                                .font(.system(size: 16))
                                .foregroundColor(.black)

                            Spacer()
                        }

                    }
                    
                }
            }
            
            
            
         
            
            
            Spacer()
            
            
            
            
            
        }.ignoresSafeArea()
            .background(Color("Background"))
        
        
        
    
    }
}

//struct AboutCompany_Previews: PreviewProvider {
//    static var previews: some View {
//        AboutCompany()
//    }
//}
