//
//  ReferProductPage1.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/2/22.
//

import SwiftUI

struct ReferProductPage1: View {
    
    
    
    
    
    
    @Binding var isShowingReferExperience:Bool
    
    var item: Items
    
    @State var selectedContactMethod:Int = 0  //0 is unselected, 1 is Email, 2 is Phone
    
    @State var textFieldEntry:String = ""
    
    
    var body: some View {
        NavigationView {
            VStack {
                //MARK: CONTENT
                List {
                    
                    //MARK: PREVIOUS REVIEW SECTION
                    Section(header: Text("Your 5 star review")) {
                        
                        //preview of review
                        HStack(alignment: .center) {
                            
                            //image
                            Image("redshorts")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4)
                                .cornerRadius(32)
                                .padding(.trailing).padding(.trailing)
                            
                            //empty review
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Joggers 2.0")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.black)
                                    .padding(.bottom, 4)
                                
                                Text("Absolutely amazing! I can't wait to get another pair")
                                    .font(.system(size: 16))
                                    .foregroundColor(.black)
                                    .padding(.bottom)
                                
                                HStack(alignment: .center) {
                                    Image(systemName: "star.fill")
                                    Image(systemName: "star.fill")
                                    Image(systemName: "star.fill")
                                    Image(systemName: "star.fill")
                                    Image(systemName: "star.fill")
                                }.font(.system(size: 18))
                                .foregroundColor(Color.yellow)

                            }
                        }
                        HStack {
                            Text("Colin P.")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color("Dark1"))
                            Spacer()
                            Label {
                                Text("Verified Buyer")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.green)
                            } icon: {
                                Image(systemName: "checkmark.seal.fill")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.green)
                            }.foregroundColor(.green)
                        }
                        
                    }
                    
                }.frame(height: 250)
                
                Text("Have someone in mind?")
                
                Text("Enter their email or phone number and we'll create a custom discount code for them.")
                
                HStack(spacing: 48) {
                    
                    Button {
                        if selectedContactMethod != 1 {
                            selectedContactMethod = 1
                        } else {
                            selectedContactMethod = 0
                        }
                    } label: {
                        Text("Email")
                            .foregroundColor(selectedContactMethod == 1 ? .blue : .black)
                            .padding()
                            .padding(.horizontal, 20)
                            .background(RoundedRectangle(cornerRadius: 12).strokeBorder().foregroundColor(selectedContactMethod == 1 ? .blue : .black))
                    }
                    
                    Button {
                        if selectedContactMethod != 2 {
                            selectedContactMethod = 2
                        } else {
                            selectedContactMethod = 0
                        }
                    } label: {
                        Text("Phone")
                            .foregroundColor(selectedContactMethod == 2 ? .blue : .black)
                            .padding()
                            .padding(.horizontal, 20)
                            .background(RoundedRectangle(cornerRadius: 12).strokeBorder().foregroundColor(selectedContactMethod == 2 ? .blue : .black))
                    }
                    
                }
                
                if selectedContactMethod != 0 {
                    HStack {
                        TextField("Write here...", text: $textFieldEntry)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical, 20)
                            .padding(.horizontal)
                            .frame(height: 80, alignment: .center)
                            .onSubmit {
                                //need to query the DB and see if the user is eligible for the discount
                            }
                        Spacer(minLength: 10)
                        Button {
                            //submit to backend to see if user is able to get a referral
                        } label: {
                            Text("Submit")
                        }
                    }
                    
                }
                    
                
                
                
                Spacer()
                
                NavigationLink {
                    ReferProductPage2()
                } label: {
                    HStack {
                        Spacer()
                        Text("Let's make someone happy!")
                            .foregroundColor(Color.white)
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .padding(.vertical, 16)
                        Spacer()
                    }.background(RoundedRectangle(cornerRadius: 36).fill(Color("ReferPurple")))
                     .padding(.horizontal)
                     .padding(.horizontal)
                }
                .padding(.bottom)
                .padding(.bottom)
            
                
                
            }.ignoresSafeArea()
        }
    }
}

//struct ReferProductPage1_Previews: PreviewProvider {
//    static var previews: some View {
//        ReferProductPage1()
//    }
//}
