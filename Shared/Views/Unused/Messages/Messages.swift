//
//  Messages.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 3/18/22.
//

import SwiftUI
import AVKit

struct Messages: View {
    @State private var isShowingVideo = false
    @State var player = AVPlayer(url: Bundle.main.url(forResource: "Streetwear", withExtension: "mov")!)
    
    var body: some View {
        VStack {

            
            VideoPlayer(player: player)
                .edgesIgnoringSafeArea(.all)
                .frame(width: 400, height: 300)
//                .gesture(DragGesture()
//                    .onChanged({ gesture in
//                        isShowingVideo = false
//                    })
//                )
            
            
//            if isShowingVideo {
                
//            }
//            else {
//                Button {
//                    isShowingVideo = true
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
//                        player.play()
//                    })
//                } label: {
//                    HStack {
//                        Spacer()
//                        Image("StreetwearStill")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: UIScreen.main.bounds.width - 40)
//                        Spacer()
//                    }
//                }
//            }
        }
        .navigationTitle("")
            .navigationBarHidden(true)
    }
}

struct Messages_Previews: PreviewProvider {
    static var previews: some View {
        Messages()
    }
}
