//
//  ReferProductPage3.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/3/22.
//

import SwiftUI

struct ReferProductPage3: View {
    
    @Binding var userSuggestedCode:String
    
    var cardWidth:CGFloat
    
    
    var customCardView: some View {
        //MARK: USER-CREATED CARD ON THE TOP
        HStack {
            
            Spacer()
            
            ZStack(alignment: .topLeading) {
                
                Rectangle().foregroundColor(.green)
                    .frame(width: cardWidth, height: cardWidth * 5 / 8)
                
                VStack {
                    
                    HStack {
                        Text("Athleisure LA")
                        Spacer()
                        Text("20% Discount")
                    }.frame(height: cardWidth * 5 / 32) //i.e. 1/4 of the card in terms of height
                    
                    HStack(alignment: .center) {
                        Spacer()
                        Text(userSuggestedCode)
                            .font(.system(size: 60, weight: .semibold))
                        Spacer()
                    }.frame(height: cardWidth * 5 / 16) //i.e. 1/2 of the card in terms of height)
                    
                    HStack {
                        Text("colinjpower1@gmail.com")
                        Spacer()
                        Text("Expires in 30 days (Oct 3)")
                    }.frame(height: cardWidth * 5 / 32) //i.e. 1/4 of the card in terms of height
                    
                }.frame(width: cardWidth, height: cardWidth * 5 / 8)
            }
            Spacer()
        }.padding(.bottom, 40)
       
    }
    
    
    var body: some View {
        VStack {
        
            customCardView
            
            Button("Save to image") {
                let image = customCardView.snapshot()
                
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
            
            
            
            Spacer()
            
            
            
            
        }
    }
}


extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

