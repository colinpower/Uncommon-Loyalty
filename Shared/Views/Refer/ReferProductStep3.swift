//
//  ReferProductStep3.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/4/22.
//

import SwiftUI

struct ReferProductStep3: View {
    
    //Environment
    
    //ViewModels
    
    //State
    @State var nameForRecipientEnteredManually:String = ""
    
    
    //Binding
    @Binding var userSelectedColor:Color
    
    @Binding var indexOfCurrentReferPage:Int
    
    //Required variables
    
    var item: Items
    var promptForStep3:String
    var screenWidth:CGFloat
    var totalHeaderHeight:CGFloat
    
    @State var wasPreviewButtonTapped:Bool = false
    
    var colorOptions:[Color] = [Color.green, Color.red, Color.purple, Color.blue, Color.yellow]
    
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            //MARK: PROMPT (80)
            Text(promptForStep3)
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.leading)
                .foregroundColor(Color("Dark1"))
                .padding(.top, 30)
                .padding(.horizontal)
                .frame(height: 54, alignment: .leading)
            
            //MARK: 1 VIEWS FOR COLOR CHOICE (110 height)
            VStack(alignment: .leading, spacing: 0) {
                
                //Empty... neither button selected, nothing posted to selectedContact or nameForRecipientEnteredManually
                    
                HStack(alignment: .center, spacing: 20 ) {
                    
//                    Image(systemName: "paintbrush.fill")
//                        .font(.system(size: 20, weight: .medium))
//                        .foregroundColor(Color("Dark1"))
                    
                    Button {
                        userSelectedColor = colorOptions[0]
                    } label: {
                        if userSelectedColor == colorOptions[0] {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(colorOptions[0])
                        } else {
                            Image(systemName: "circle")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(colorOptions[0])
                        }
                    }
                    
                    Button {
                        userSelectedColor = colorOptions[1]
                    } label: {
                        
                        if userSelectedColor == colorOptions[1] {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(colorOptions[1])
                        } else {
                            Image(systemName: "circle")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(colorOptions[1])
                        }
                        
                    }
                    
                    Button {
                        userSelectedColor = colorOptions[2]
                    } label: {
                        
                        if userSelectedColor == colorOptions[2] {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(colorOptions[2])
                        } else {
                            Image(systemName: "circle")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(colorOptions[2])
                        }
                    }
                    
                    Button {
                        userSelectedColor = colorOptions[3]
                    } label: {
                        
                        if userSelectedColor == colorOptions[3] {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(colorOptions[3])
                        } else {
                            Image(systemName: "circle")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(colorOptions[3])
                        }
                    }
                    
                    Button {
                        userSelectedColor = colorOptions[4]
                    } label: {
                        
                        if userSelectedColor == colorOptions[4] {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(colorOptions[4])
                        } else {
                            Image(systemName: "circle")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(colorOptions[4])
                        }
                    }
                    
                    Spacer()
                    
                    
                }
                .padding(.horizontal)
                .padding(.top, 35)
                .padding(.bottom, 35)
                .frame(width: UIScreen.main.bounds.width, height: 110)
                
                
            }.frame(width: screenWidth, height: 110)
            
            
            
            //MARK: BUTTONS
            HStack(alignment: .center) {
                
                //MARK: BACK BUTTON
                
                Button {

                    //zoom to the prior question
                    withAnimation(.linear(duration: 0.15)) {
                        indexOfCurrentReferPage -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 60, height: 48)
                        .background(RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(Color("ReferPurple")))
                }
                
                Spacer()
                
                //MARK: PREVIEW BUTTON
                Button {
                    
                    //zoom to the next question
                    withAnimation(.linear(duration: 0.15)) {
                        indexOfCurrentReferPage += 1
                    }
                } label: {
                    HStack (alignment: .center, spacing: 2) {
                        Text("Preview")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(userSelectedColor == .gray ? Color("Background") : .white)
                        Image(systemName: "arrow.right")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(userSelectedColor == .gray ? Color("Background") : .white)
                    }
                    .frame(width: 160, height: 48)
                    .background(RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(userSelectedColor == .gray ? Color("Background") : Color("ReferPurple")))
                }.disabled(userSelectedColor == .gray)
                
                
            }
            .padding(.horizontal)
            .frame(height: 48, alignment: .center)
            
            
            
            
            Spacer()
            
            
        }
        .background(Color("Background"))
        .ignoresSafeArea()
        .frame(width: screenWidth, height: UIScreen.main.bounds.height-totalHeaderHeight)
        .onAppear {
            print("We're on page \(indexOfCurrentReferPage)")
            //print(reviewQuestionForThisPage)
        }
        
        
        
        
        
        
    }
}

