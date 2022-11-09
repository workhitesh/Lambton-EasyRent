//
//  Extension+Number.swift
//  EasyRent
//
//  Created by Hitesh on 2022-11-09.
//

import Foundation

extension Double {
    var clean: String {
        let d = self.rounded()
        return d.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", d) : String(d)
    }
}
