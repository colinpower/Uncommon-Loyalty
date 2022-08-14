//
//  ReviewProductCarousel2.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 7/21/22.
//

import SwiftUI

struct ReviewProductCarousel2: View {
    
    @Binding var showingAnimation:Bool
    
    var body: some View {
//        ZStack {
            AnimatedBackground().edgesIgnoringSafeArea(.all).blur(radius: 50, opaque: true)
//            VStack {
//                SheetHeader(title: "Animation", isActive: $showingAnimation)
//            }
//        }
        
    }
}

struct ReviewProductCarousel2_Previews: PreviewProvider {
    static var previews: some View {
        ReviewProductCarousel2(showingAnimation: .constant(true))
    }
}
                
                
struct AnimatedBackground: View {
    
    //@Binding var showingReviewProductScreen: Bool
    @State var animate = false
    
    @State var start = CGFloat(25)
    @State var end = CGFloat(400)
//
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    let colors = [Color("ThemeLight"), Color("ThemePrimary"), Color("DeepPurple")] // , Color("ThemePrimary"), Color("ThemeLight")]
    
    
    var body: some View {
            
        RadialGradient(colors: colors, center: .center, startRadius: start, endRadius: end)
            .ignoresSafeArea()
            .onReceive(timer, perform: { _ in
                withAnimation(.easeInOut(duration: 5.0).repeatForever(autoreverses: true)) {
                    self.start = CGFloat(25)
                    self.end = CGFloat(170)
                }
            })
//            .onAppear {
//                withAnimation(.easeInOut(duration: 5.0).repeatForever(autoreverses: true)) {
//                    animate.toggle()
//                }
//            }
            
            
            //gradient: Gradient(colors: colors), startPoint: animate ? .topLeading " ", endPoint: end)
            //.withAnimation(Animation.easeInOut(duration: 4).repeatForever())
        
        //    .animation(Animation.easeInOut(duration: 1).repeatForever())
//            .onReceive(timer, perform: { _ in
//                self.start = UnitPoint(x: 4, y: 0)
//                self.end = UnitPoint(x: 0, y: 2)
//                self.start = UnitPoint(x: -4, y: 20)
//                self.end = UnitPoint(x: 4, y: 0)
//        })
    }
}

