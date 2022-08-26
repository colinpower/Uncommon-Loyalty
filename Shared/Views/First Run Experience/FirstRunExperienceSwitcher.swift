//
//  FirstRunExperienceSwitcher.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/12/22.
//

import SwiftUI

struct FirstRunExperienceSwitcher: View {
    
    @AppStorage("hasShownFRE")
    var hasShownFRE: Bool = false
    
    
    var body: some View {
        
        if !hasShownFRE {
            FirstRunExperience()
        } else {
//            Home()
            EmptyView()
        }
    }
}

struct FirstRunExperienceSwitcher_Previews: PreviewProvider {
    static var previews: some View {
        FirstRunExperienceSwitcher()
    }
}
