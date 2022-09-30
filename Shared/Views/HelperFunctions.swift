//
//  HelperFunctions.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 4/22/22.
//

import Foundation

//dateformatting help!!
//https://stackoverflow.com/questions/35700281/date-format-in-swift

func convertTimestampToString(timestamp: Int, format: String? = "MMMM d") -> String {
    //let dateNow = Date()
    //let unixNow = dateNow.timeIntervalSince1970
    
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
        formatter.dateFormat = format
        
        return formatter.string(from: date1)
//    }
}







//extension Calendar {
//    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
//            let fromDate = startOfDay(for: from) // <1>
//            let toDate = startOfDay(for: to) // <2>
//            let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
//
//            return numberOfDays.day!
//        }
//}


//func createLast60DaysPointsArray(transactions: [Transactions], currentBalance: Int) -> [Int] {
//    //current date: NSDate().timeIntervalSince1970
//    //60 days ago: NSDate().timeIntervalSince1970 - 60*86400
//    
//    //return .numberOfDaysBetween(from: NSDate().timeIntervalSince1970, to: NSDate().timeIntervalSinceNow)
//    var resultArray = Array(repeating: 0, count: 60)
//    
//    var lastBalance = currentBalance
//    
//    resultArray[59] = currentBalance
//    
//    for index in transactions.indices {
//        let num = numberOfDaysSince(timestamp: transactions[index].timestamp)
//        let offset = 59-num
//        let pointsDelta = transactions[index].pointsEarnedOrSpent
//        
//        resultArray[offset] = lastBalance - pointsDelta
//        
//        lastBalance -= pointsDelta
//        
//        //print(String(transactions[index].timestamp))
//        //print(String(lastBalance))
//        //print(resultArray)
//    }
//    
//    print("result array")
//    print(resultArray)
//    
//    var runningVar = resultArray[59]
//    
//    resultArray = resultArray.reversed()
//    
//    for index2 in resultArray.indices {
//        if resultArray[index2] == 0 {
//            resultArray[index2] = runningVar
//        } else {
//            runningVar = resultArray[index2]
//        }
//    }
//    resultArray = resultArray.reversed()
//    
//    print("final result array")
//    print(resultArray)
//    
//    
//    
//    //MARK: MUST DELETE THIS REVERSAL
//    resultArray = resultArray.reversed()
////    print("result array")
////    print(resultArray)
////    ForEach(transactions.indices.prefix(3), id: \.self) { index in
////        print(index)
////    }
//    
//    return(resultArray)
//    
//}
//
//func numberOfDaysSince(timestamp: Int) -> Int {
//    
//    let calendar = Calendar.current
//    
//    let date1 = calendar.startOfDay(for: Date(timeIntervalSince1970: Double(timestamp)))
//    let date2 = calendar.startOfDay(for: Date())
//    
//    let components = calendar.dateComponents([.day], from: date1, to: date2)
//        
//    //in case you get a day that's too long ago, just make it part of the 1st day (i.e. the day 59 days ago)
//    if components.day ?? 0 > 59 {
//        return 59
//    } else {
//        return components.day ?? 1
//    }
//    //return String((NSDate().timeIntervalSince1970))
//}
