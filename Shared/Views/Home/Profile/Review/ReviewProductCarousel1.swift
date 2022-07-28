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
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                //Background color
                Color(red: 123/255, green: 179/255, blue: 246/255)
                
                
                //Pages that you scroll through
                ScrollView(.vertical) {
                    VStack {
                        //MARK: PAGE 1 (Title and First Question)
                        VStack (alignment: .leading) {
                            Spacer()
                            HStack(alignment: .center) {
                                
                                VStack(alignment: .leading) {
                                    Text("1 / 3")
                                        .foregroundColor(Color(red: 20/255, green: 52/255, blue: 97/255))
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
                                        withAnimation(.linear(duration: 0.25)) {
                                            verticalOffset -= geometry.size.height
                                        }
                                    } label: {
                                        HStack {
                                            Text("OK")
                                                .foregroundColor(self.rating == 0 ? .white.opacity(0.6) : .white)
                                                .font(.headline)
                                            Image(systemName: "checkmark")
                                                .foregroundColor(self.rating == 0 ? .white.opacity(0.6) : .white)
                                                .font(.headline)
                                        }.padding()
                                        .background(RoundedRectangle(cornerRadius: 8)
                                            .fill(self.rating == 0 ? Color(red: 20/255, green: 52/255, blue: 97/255).opacity(0.8) : Color(red: 20/255, green: 52/255, blue: 97/255)))
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
                                        .foregroundColor(Color(red: 20/255, green: 52/255, blue: 97/255))
                                        .font(.headline)
                                        .padding(.bottom, 48)
                                    Text("How would you describe the quality of the fabric?")
                                        .foregroundColor(Color(red: 20/255, green: 52/255, blue: 97/255))
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .padding(.bottom, 24)
                                    Text("Write here...")
                                        .foregroundColor(Color(red: 20/255, green: 52/255, blue: 97/255).opacity(0.6))
                                        .font(.title2)
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
                                        .fill(Color(red: 20/255, green: 52/255, blue: 97/255)))
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
                                            .foregroundColor(Color(red: 20/255, green: 52/255, blue: 97/255))
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
                }
                // X button, footer, header
                VStack(spacing:0) {
                    ZStack {
                        Color(red: 93/255, green: 151/255, blue: 243/255)
                        HStack {
                            Text("Joggers 2.0")
                                .foregroundColor(Color(red: 20/255, green: 52/255, blue: 97/255))
                                .font(.title)
                                .fontWeight(.semibold)
                            Spacer()
                            Button {
                                showingReviewProductScreen = false
                                print("x button tapped")
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(Color(red: 20/255, green: 52/255, blue: 97/255))
                                    .font(.largeTitle)
                            }
                            
                        }.padding(.horizontal, 16)
                        .padding(.top, 40)
                    }.frame(height: 120)
                    Spacer()
                    ZStack {
                        Color(red: 93/255, green: 151/255, blue: 243/255)
                        HStack {
                            Button {
                                withAnimation(.linear(duration: 0.25)) {
                                    verticalOffset += geometry.size.height
                                }
                            } label: {
                                Image(systemName: "arrow.up.circle.fill")
                                    .foregroundColor(Color(red: 20/255, green: 52/255, blue: 97/255))
                                    .font(.largeTitle)
                            }.disabled(verticalOffset == 0)

                            Button {
                                withAnimation(.linear(duration: 0.25)) {
                                    verticalOffset -= geometry.size.height
                                }
                            } label: {
                                ZStack {
                                    Circle()
                                        .foregroundColor(.white)
                                        .frame(width: 30, height: 30, alignment: .center)
                                    Image(systemName: "arrow.down.circle.fill")
                                        .foregroundColor(Color(red: 20/255, green: 52/255, blue: 97/255))
                                        .font(.largeTitle)
                                }
                            } //.disabled(verticalOffset == 0)
                            
                            Spacer()
                            Text("150 points")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }.padding(.horizontal)
                    }.frame(height: 80)
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





//VStack(spacing: 0) {
//    ZStack (alignment: .center) {
//        Image("ReviewBackground")
//            .resizable()
//            .scaledToFill()
//            .frame(width: geometry.size.width, height: geometry.size.height / 3, alignment: .center)
//        Image("AthleisureSweatpants")
//            .resizable()
//            .scaledToFill()
//            .frame(width: geometry.size.width / 3, height: geometry.size.height / 6, alignment: .center)
//            .clipped()
//            .cornerRadius(20)
//            .shadow(color: .gray, radius: 10, x: 4, y: 4)
//            .offset(x: 0, y: 25)
//        VStack {
//            HStack(alignment: .center) {
//                Spacer()
//                Button {
//                    showingReviewProductScreen = false
//                    print("x button tapped")
//                } label: {
//                    Image(systemName: "x.circle")
//                        .font(.title)
//                        .foregroundColor(Color(UIColor.black))
//                }
//            }.padding(.trailing, 24)
//            Spacer()
//        }.padding(.top, 48)
//          .frame(width: geometry.size.width, height: geometry.size.height / 3, alignment: .center)
//    }
//     //   .frame(width: geometry.size.width, height: geometry.size.height / 3, alignment: .center)
//    ZStack {
//        Color.blue
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 0) {
//                //MARK: Question 1
//                VStack {
//                    Text("Message 1")
//                    Text("ENTER A RESPONSE")
//                    Spacer()
//                    Button {
//                        withAnimation(.linear(duration: 0.13)) {
//                            horizontalOffset = -1*geometry.size.width
//                        }
//
//                    } label: {
//                        Text("Next")
//                    }
//                }
//                .frame(width: geometry.size.width)
////                                        .background(RoundedRectangle(cornerRadius: 0)
////                                        .fill(Color(UIColor.lightGray)))
//                    .offset(x: horizontalOffset)
//
//                VStack {
//                    Text("Message 2")
//                    HStack {
//                        Button {
//                            withAnimation(.linear(duration: 0.13)) {
//                                horizontalOffset = -2*geometry.size.width
//                            }
//                        } label: {
//                            Text("Next")
//                        }
//                        Button {
//                            withAnimation(.linear(duration: 0.13)) {
//                                horizontalOffset = 0
//                            }
//                        } label: {
//                            Text("Previous")
//                        }
//                    }
//                }.frame(width: geometry.size.width) //, height: geometry.size.height/3*2)
//                    .background(RoundedRectangle(cornerRadius: 0)
//                    .fill(Color(UIColor.red)))
//                    .offset(x: horizontalOffset)
//            }
//        } //.frame(width: geometry.size.width, height: geometry.size.height/3*2)
//    }
//} //.frame(width: geometry.size.width, height: geometry.size.height)
