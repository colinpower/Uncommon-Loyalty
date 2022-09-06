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
                    
                    //MARK: IMAGES for poll
                    VStack(alignment: .leading, spacing: 6) {
                        Image("Athleisure LA")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Text("Athleisure LA Poll")
                            .font(.system(size: 24, weight: .bold))
                    }
                
                    //MARK: IMAGES for poll
                    PollTabView(arrayOfImagesForEachOption: $arrayOfImagesForEachOption, arrayOfTitlesForEachOption: $arrayOfTitlesForEachOption)
                            .frame(height: UIScreen.main.bounds.height / 3)
                            .background(.gray)
                    
                    //MARK: PROMPT for poll
                    Text("What do you think?")
                        .font(.system(size: 24, weight: .semibold))
                    
                    
                    //MARK: RESPONSE OPTIONS for poll
                    if userChoseOption == -1 {
                        PollAllOptionsUnselected(userChoseOption: $userChoseOption, arrayOfNumberOfResponsesForEachOption: $arrayOfNumberOfResponsesForEachOption, arrayOfTitlesForEachOption: arrayOfTitlesForEachOption)
                    } else {
                        PollAllOptionsSelected(arrayOfNumberOfResponsesForEachOption: arrayOfNumberOfResponsesForEachOption, animatedArray: $animatedArray, arrayOfTitlesForEachOption: arrayOfTitlesForEachOption, userChoseOption: userChoseOption)
                    }
                    
                    //MARK: NOTIFY ME SECTION
                    if animateTheNotifyMeSection {
                        VStack {
                            Button {
                                //set notifications for user
                                userWantsToBeNotified.toggle()
                                
                                //post to Firebase
                                
                            } label: {
                                HStack(alignment: .center, spacing: 16) {
                                    Text("Email me if this gets made")
                                        .font(.system(size: 24, weight: .regular))
                                        .foregroundColor(.black)
                                    if userWantsToBeNotified {
                                        Image(systemName: "checkmark.square.fill")
                                            .font(.system(size: 32, weight: .medium))
                                            .foregroundColor(.blue)
                                    } else {
                                        Image(systemName: "checkmark.square")
                                            .font(.system(size: 32, weight: .medium))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            
                            
                        }
                    }
                    
                    
                    
                    
                    //MARK: Comments
                    VStack {
                        Text("commment 1")
                        Text("response 1").padding(.leading, 40)
                        Text("commment 2")
                        Text("commment 3")
                        Text("response 3").padding(.leading, 40)
                        Text("commment 4")
                    }
                    Spacer()
                    
                }.onChange(of: userChoseOption) { newValue in
                    withAnimation {
                        animateTheNotifyMeSection = true
                    }
                    
                }
            }
             
            MyTabView(selectedTab: $selectedTab)
        }
        .background(.white)
        .edgesIgnoringSafeArea([.bottom, .horizontal])
        .navigationBarTitle("Poll", displayMode: .inline)
        .onAppear {
            animatedArray = [Int](repeating: 0, count: arrayOfTitlesForEachOption.count)
        }
    }
}
