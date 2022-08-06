//
//  HelperFunctions.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 4/22/22.
//

import Foundation

//dateformatting help!!
//https://stackoverflow.com/questions/35700281/date-format-in-swift

func convertTimestampToString(timestamp: Int) -> String {
    let dateNow = Date()
    let unixNow = dateNow.timeIntervalSince1970
    
    //check how long it's been
//    if (Int(unixNow) - timestamp < 86400) {
//        //if it's been < 1 day, write "Today at 3:43 PM"
//        let date1 = Date(timeIntervalSince1970: Double(timestamp))
//        let formatter = DateFormatter()
//        formatter.dateFormat = "h:mm a"
//
//        let timeString = formatter.string(from: date1)
//
//        return timeString
//    } else {
        //else, write "Oct 12, 3:43 PM"
        let date1 = Date(timeIntervalSince1970: Double(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        
        return formatter.string(from: date1)
//    }
}
