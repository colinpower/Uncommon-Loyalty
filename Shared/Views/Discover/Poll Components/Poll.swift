//
//  Poll.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/5/22.
//

import SwiftUI

struct Poll: View {
        
    @State var isShowingComments: Bool = false
    @State var arrayOfImagesForEachOption = ["OPTION 1", "OPTION 2", "OPTION 3"]
    @State var arrayOfTitlesForEachOption = ["OPTION 1", "OPTION 2", "OPTION 3"]
    
    @State var arrayOfNumberOfResponsesForEachOption:[Int] = [33, 60, 82]
    @State var arrayOfNumberOfResponsesSoAnimationStartsAtZero:[Int] = [0, 0, 0]
    
    @State var animatedArray:[Int] = []
    
    @State var userChoseOption = -1
    
    @State var userWantsToBeNotified:Bool = false
    
    @State var animateTheNotifyMeSection:Bool = false
    
    @Binding var tempItemID:String
    
    @Binding var selectedTab:Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    //MARK: HEADER for poll
                    
                    //MARK: HEADER (STAR + "REFER" AT THE TOP)
                    VStack(alignment: .leading, spacing: 8) {
                        Image("Athleisure LA")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .cornerRadius(8)
                        HStack(alignment: .bottom, spacing: 0) {
                            Text("Poll")
                                .font(.system(size: 36, weight: .bold, design: .rounded))
                                .foregroundColor(Color("Dark1"))
                            Spacer()
                        }
                    }.padding(.horizontal).padding(.top)
                    
                    
                    //MARK: PROMPT for poll
                    Text("We're thinking about making one of these swim suits. Do you have a favorite?")
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 20, weight: .semibold))
                        .padding(.leading)
                        .padding(.top)
                    
                    //MARK: IMAGES for poll
                    PollTabView(arrayOfImagesForEachOption: $arrayOfImagesForEachOption, arrayOfTitlesForEachOption: $arrayOfTitlesForEachOption)
                    
                    //MARK: RESPONSE OPTIONS for poll
                    if userChoseOption == -1 {
                        PollAllOptionsUnselected(userChoseOption: $userChoseOption, arrayOfNumberOfResponsesForEachOption: $arrayOfNumberOfResponsesForEachOption, arrayOfTitlesForEachOption: arrayOfTitlesForEachOption)
                            .padding()
                            .padding(.horizontal)
                            .padding(.bottom)
                    } else {
                        PollAllOptionsSelected(arrayOfNumberOfResponsesForEachOption: arrayOfNumberOfResponsesForEachOption, animatedArray: $animatedArray, arrayOfTitlesForEachOption: arrayOfTitlesForEachOption, userChoseOption: userChoseOption)
                            .padding()
                            .padding(.horizontal)
                            .padding(.bottom)
                    }
                    
                    //MARK: NOTIFY ME SECTION
                    if animateTheNotifyMeSection {
                        VStack {
                            Button {
                                //set notifications for user
                                userWantsToBeNotified.toggle()
                                
                                //post to Firebase
                                
                            } label: {
                                HStack(alignment: .center, spacing: 0) {
                                    Image(systemName: "bell")
                                        .font(.system(size: 18, weight: .regular))
                                        .foregroundColor(.blue)
                                        .padding(.trailing, 6)
                                    
                                    Text("Email me if this item gets made!")
                                        .font(.system(size: 16, weight: .regular))
                                        .foregroundColor(.black)
                                    Spacer()
                                    if userWantsToBeNotified {
                                        Image(systemName: "checkmark.square.fill")
                                            .font(.system(size: 18, weight: .regular))
                                            .foregroundColor(.blue)
                                    } else {
                                        Image(systemName: "checkmark.square")
                                            .font(.system(size: 18, weight: .medium))
                                            .foregroundColor(.black)
                                    }
                                }.padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
                                .padding()
                            }
                            
                            
                        }.padding(.bottom)
                    }
                    
                    
                    
                    
                    //MARK: Comments
                    Text("Comments")
                        .font(.system(size: 28, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.bottom, 4)
                        .padding(.leading)
                    VStack {
                        HStack{
                            Image(systemName: "person.fill")
                                .font(.system(size: 18, weight: .medium))
                                .padding(.trailing, 6)
                            Text("I really love this one!!! But the red only!")
                            Image(systemName: "heart")
                                .font(.system(size: 12, weight: .medium))
                        }.padding(.horizontal)
                        Divider().padding(.vertical, 2)
                        HStack{
                            Image(systemName: "person.fill")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.purple)
                                .padding(.trailing, 6)
                            Text("I really love this one!!! But the red only!")
                            Image(systemName: "heart")
                                .font(.system(size: 12, weight: .medium))
                        }.padding(.horizontal).padding(.leading, 20)
                        
                        
                        
                        
                        Text("commment 1")
                        Text("response 1").padding(.leading, 40)
                        Text("commment 2")
                        Text("commment 3")
                        Text("response 3").padding(.leading, 40)
                        Text("commment 4")
                    }.background(.white)
                    Spacer()
                    
                }.onChange(of: userChoseOption) { newValue in
                    withAnimation {
                        animateTheNotifyMeSection = true
                    }
                    
                }
            }
        }
        .background(Color("Background"))
        .edgesIgnoringSafeArea([.bottom, .horizontal])
        .navigationBarTitle("Athleisure LA", displayMode: .inline)
        .onAppear {
            animatedArray = [Int](repeating: 0, count: arrayOfTitlesForEachOption.count)
        }
    }
}
