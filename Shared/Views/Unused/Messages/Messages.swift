//
//  Messages.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 3/18/22.
//

import SwiftUI
import AVKit

struct Messages: View {
    @State private var isShowingVideo = true
    @State private var player = AVPlayer()
    
    var body: some View {
        VStack {

            if isShowingVideo {
                VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: "IMG_6178", withExtension: "MOV")!))
                    .edgesIgnoringSafeArea(.all)
                    .gesture(DragGesture()
                        .onChanged({ gesture in
                            isShowingVideo = false
                        })
                    )
            }
            else {
                EmptyView()
            }
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
