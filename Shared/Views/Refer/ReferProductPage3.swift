//
//  ReferProductPage3.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/3/22.
//
import Foundation
import SwiftUI
import UIKit
import MobileCoreServices



//MARK: HACK necessary to pass the correct image to the share sheet
enum ActiveSheet: String, Identifiable { // <--- note that it's now Identifiable
    case shareSheet
    var id: String {
        return self.rawValue
    }
}



struct ReferProductPage3: View {
    
    
    @State private var customCardViewSnapshot: UIImage? = nil
    @State var activeSheet: ActiveSheet? = nil
    
    @Binding var userSuggestedCode:String
    
    var cardWidth:CGFloat
    
    @State var isReferralShareSheetActive:Bool = false
    
//    @State var customCardViewSnapshot:UIImage
    
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
        
            VStack {
                           
                customCardView
                
                Button {
                    customCardViewSnapshot = customCardView.snapshot()
                    self.activeSheet = .shareSheet
                    //customCardViewSnapshot = customCardView.snapshot()
                    //isReferralShareSheetActive.toggle()
                    
                } label: {
                    Text("SEND TO YOUR FRIENDS")
                }
                
            }
            .sheet(item: $activeSheet) { [customCardViewSnapshot] sheet in
                
                switch sheet {
                case .shareSheet:
                    
                    //confirm that you've been able to convert the card into an image
                    if let unwrappedImage = customCardViewSnapshot {
                        ReferralShareSheet(photo: unwrappedImage)
                    }
//                    ReferralShareSheet(activityItems: ["Hey, I created a discount code for you!", customCardViewSnapshot as Any ])  //UIImage(imageLiteralResourceName: "Athleisure LA")])
                }
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


//MARK: creating a VC to show the share sheet
struct ReferralShareSheet: UIViewControllerRepresentable {
    //@Binding var isShareSheetActive: Bool
    
    let photo: UIImage
    
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
    
//    let activityItems: [Any] = [photo]
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil ///[.postToFacebook]   //nil
    let callback: Callback? = nil
    
    //var items : [Any]

    func makeUIViewController(context: Context) -> UIViewController {
        
        let activityItems: [Any] = [photo]
        
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities)
        
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {  }
    
}




//MARK: UNUSED BUT USEFUL FUNCTIONS
//save card to photos
//Button("Save to image") {
//    let image = customCardView.snapshot()
//
//    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//}
