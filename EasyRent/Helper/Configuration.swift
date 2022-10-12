//
//  Configuration.swift
//  EasyRent
//
//  Created by Hitesh on 2022-10-12.
//

import Foundation

//MARK:- Only prints items in debug mode
func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    //        let formatter = DateFormatter()
    //        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS "
    //comment or no for non-private functions for print
    Swift.print(/*formatter.string(from: Date()),*/ "-- \n", items[0], separator:separator, terminator: terminator)
    #else
    //Swift.print(items[0], separator:separator, terminator: terminator)
    //Swift.print("Release mode")
    #endif
}
