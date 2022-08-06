//
//  ReviewProductCarousel1.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 7/21/22.
//

import SwiftUI

struct ReviewProductCarousel1: View {
    
    @Binding var showingReviewProductScreen: Bool
    
    @State var verticalOffset : CGFloat = 0
    
    @State var rating : Int = 0
    
    @State var question1: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                //Background color
                Color("Background")
                
                //Pages that you scroll through
                ScrollView(.vertical) {
                    //MARK: PAGE 1 (Title and First Question)
                    VStack (alignment: .leading) {
                        Spacer()
                        HStack(alignment: .center) {
                            
                            VStack(alignment: .leading) {
                                Text("1 / 3")
                                    .foregroundColor(Color("Dark1"))
                                    .font(.headline)
                                    .padding(.bottom, 48)
                                Text("What would you rate this item?")
                                    .foregroundColor(Color(red: 20/255, green: 52/255, blue: 97/255))
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                Text("1 = Not good, 5 = Amazing")
                                    .foregroundColor(Color(red: 20/255, green: 52/255, blue: 97/255))
                                    .font(.body)
                                    .italic()
                                    .padding(.bottom, 24)
                                RatingView(rating: $rating)

                                Divider().opacity(0.0)
                                    .padding(.bottom, 24)
                                
                                Button {
                                    //withAnimation(scaleEffect(1.1))
                                    //.scaleEffect(1.1)
                                    withAnimation(.linear(duration: 0.25)) {
                                        verticalOffset -= geometry.size.height
                                    }
                                    //.animation(.easeInOut(duration: 0.2), value: rating)
                                } label: {
                                    HStack {
                                        Text("OK")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                    }.padding()
                                    .background(RoundedRectangle(cornerRadius: 8)
                                        .fill(self.rating == 0 ? Color("Gray2") : Color("ThemeBright")))
                                }.disabled(self.rating == 0)
                            }
                                
                        }.padding(.horizontal)
                        Spacer()
                    }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                        .offset(y: verticalOffset)
                    
                    
                    //MARK: PAGE 2 (Second Question)
                    VStack (alignment: .leading) {
                        Spacer()
                        HStack(alignment: .center) {
                            
                            VStack(alignment: .leading) {
                                Text("2 / 3")
                                    .foregroundColor(Color("Dark1"))
                                    .font(.headline)
                                    .padding(.bottom, 48)
                                Text("How would you describe the quality of the fabric?")
                                    .foregroundColor(Color(red: 20/255, green: 52/255, blue: 97/255))
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .padding(.bottom, 24)
                                TextField("Write here...", text: $question1)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                                    Text("Write here...")
//                                        .foregroundColor(Color(red: 20/255, green: 52/255, blue: 97/255).opacity(0.6))
//                                        .font(.title2)
                                Divider()
                                    .padding(.bottom, 24)
                                
                                Button {
                                    withAnimation(.linear(duration: 0.25)) {
                                        verticalOffset -= geometry.size.height
                                    }
                                } label: {
                                    HStack {
                                        Text("OK")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                    }.padding()
                                    .background(RoundedRectangle(cornerRadius: 8)
                                        //.fill(Color("ThemeBright"))
                                        .fill(self.question1 == "" ? Color("Gray2") : Color("ThemeBright")))
                                }
                            }
                                
                        }.padding(.horizontal)
                        Spacer()
                    }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                        .offset(y: verticalOffset)
                    
                    //MARK: Page 3 (final question and completion)
                    VStack (alignment: .leading) {
                        Spacer()
                        HStack(alignment: .center) {
                            VStack(alignment: .center) {
                                VStack(alignment: .leading) {
                                    Text("3 / 3")
                                        .foregroundColor(Color("Dark1"))
                                        .font(.headline)
                                        .padding(.bottom, 48)
                                    Text("How was the shipping process?")
                                        .foregroundColor(Color(red: 20/255, green: 52/255, blue: 97/255))
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .padding(.bottom, 24)
                                    Text("Write here...")
                                        .foregroundColor(Color(red: 20/255, green: 52/255, blue: 97/255).opacity(0.6))
                                        .font(.title2)
                                    Divider()
                                        .padding(.bottom, 24)
                                }
                                
                                Button {
                                    //NEED TO POST BACK TO FIREBASE HERE
                                    showingReviewProductScreen = false
                                } label: {
                                    HStack {
                                        Text("Submit")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                    }.padding()
                                    .padding(.horizontal, 32)
                                    .background(RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(red: 20/255, green: 52/255, blue: 97/255)))
                                }
                            }
                            
                            
                                
                        }.padding(.horizontal)
                        Spacer()
                    }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                        .offset(y: verticalOffset)
                }
                .ignoresSafeArea(.keyboard)
                // X button, footer, header
                VStack(spacing:0) {
                    ZStack {
                        Color("Background")
                        SheetHeader(title: "Joggers 2.0", isActive: $showingReviewProductScreen)
                    }.frame(height: 108)
                    Spacer()
                    ZStack {
                        Color("Background")
                        HStack {
                            Button {
                                withAnimation(.linear(duration: 0.25)) {
                                    verticalOffset += geometry.size.height
                                }
                            } label: {
                                Image(systemName: "arrow.up.circle.fill")
                                    .foregroundColor(Color("ThemeBright"))
                                    .font(Font.system(size: 32, weight: .semibold))
                            }.disabled(verticalOffset == 0)

                            Button {
                                withAnimation(.linear(duration: 0.25)) {
                                    verticalOffset -= geometry.size.height
                                }
                            } label: {
                                ZStack {
                                    Circle()
                                        .foregroundColor(.white)
                                        .frame(width: 32, height: 32, alignment: .center)
                                    Image(systemName: "arrow.down.circle.fill")
                                        .foregroundColor(Color("ThemeBright"))
                                        .font(Font.system(size: 32, weight: .semibold))
                                }
                            } //.disabled(verticalOffset == 0)
                            
                            Spacer()
                            Text("150 points")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Dark1"))
                        }.padding(.horizontal)
                    }.frame(height: 96)
                }
            }
            .ignoresSafeArea()
            
        }
    }
}

struct ReviewProductCarousel1_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ReviewProductCarousel1(showingReviewProductScreen: .constant(true))
        }
    }
}
