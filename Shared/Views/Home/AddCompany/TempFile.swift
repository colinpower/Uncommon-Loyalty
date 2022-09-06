//
//  SwiftUIView.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/11/22.
//

import SwiftUI

struct TempFile: View {
    
    @Binding var showTempFile:Bool
    
    var body: some View {
        
        
        VStack {
            
            
            Text("hello world")
            
            Button {
                showTempFile = false
            } label: {
                Text("disappear this view")
            }
            
            
        }.onAppear {
            print("TempFile appeared")
        }
        .onDisappear {
            
            print("TempFile disappeared")
            showTempFile = false
        }
        
    }
}

//struct TempFile_Previews: PreviewProvider {
//    static var previews: some View {
//        TempFile()
//    }
//}
