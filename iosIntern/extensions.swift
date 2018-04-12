//
//  extensions.swift
//  iosIntern
//
//  Created by Manolescu Mihai Alexandru on 12/04/2018.
//  Copyright © 2018 ValiTeam. All rights reserved.
//

import Foundation
import UIKit

//MARK EXTENSION for character access in string.
//this extension is needed in swift 3, since only swift 4 allows character access by subscript in a string.
//this will allow us to access specific characters in a string by an index, similarly to an array:
extension String {
    
    var length: Int {
        return self.count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
}

