//
//  Helpers.swift
//  BikeStationList
//
//  Created by Ceboolion on 08/05/2024.
//

import UIKit

class Helpers {
    
    static func printSystemFonts() {
        let identifier: String = "[SYSTEM FONTS]"
        for family in UIFont.familyNames as [String] {
            debugPrint("\(identifier) FONT FAMILY :  \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                debugPrint("\(identifier) FONT NAME :  \(name)")
            }
        }
    }
    
}
