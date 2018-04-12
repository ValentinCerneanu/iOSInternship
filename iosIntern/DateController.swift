//
//  DateController.swift
//  iosIntern
//
//  Created by Manolescu Mihai Alexandru on 12/04/2018.
//  Copyright © 2018 ValiTeam. All rights reserved.
//

import Foundation
import UIKit



func getDifference(between dateOne: Date, and dateTwo: Date) -> Int
{
    let components = Calendar.current.dateComponents([.weekOfYear, .month, .day, .hour, .minute, .second], from: dateOne, to: dateTwo)
    
    print(dateOne)
    print(dateTwo)
    print("difference is \(components.hour ?? 0) hours \(components.minute ?? 0) minutes and \(components.second ?? 0) seconds")
    
    var seconds=0;
    
    seconds = (components.hour!*3600) + (components.minute!*60) + components.second!

    return seconds
}


//create a specific format type that we will use to display the date:
func specifiedFormat() -> DateFormatter
{
    let formatter = DateFormatter()
    
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.timeZone = TimeZone.current
    formatter.locale = Locale(identifier: "en_US_POSIX")
    
    return formatter
}

//converts the date into a string:
func getDateAsString(_ date: Date) -> String
{
    let formatter = specifiedFormat()
    
    let str: String
    str = formatter.string(from: date)
    
    var result = String()
    result = "\(str[5])\(str[6])/\(str[8])\(str[9]) \(str[11])\(str[12]):\(str[14])\(str[15])"
    
    return result
}

//this is the exact date in the moment of running this line of code:
func getCurrentDate() -> Date
{
    
    let date = Date()
    
    return date
}
