//
//  Utility.swift
//  EasyRent
//
//  Created by Hitesh on 2022-10-12.
//

import Foundation

final class Utility {
    class func isPostalCodeValid(_ code:String) -> Bool {
        var isValidArr = [Bool]()
        for i in 0..<code.count {
            let char = code[i]
            // check if even
            if i%2 == 0 {
                isValidArr.append(char.isOnlyAlphabet)
            } else {
                isValidArr.append(char.isOnlyNumbers)
            }
        }
        return !isValidArr.contains(false) && isValidArr.count == 6
    }
}
