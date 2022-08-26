//
//  HowToUseDiscountModal.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/26/22.
//

import SwiftUI

struct HowToUseDiscountModal: View {
    
    @Binding var isShowingHowDoIUseDiscount:Bool
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button {
                isShowingHowDoIUseDiscount.toggle()
            } label: {
                Text("dismiss")
            }
        }
        
        
        
    }
}

struct HowToUseDiscountModal_Previews: PreviewProvider {
    static var previews: some View {
        HowToUseDiscountModal(isShowingHowDoIUseDiscount: .constant(true))
    }
}
