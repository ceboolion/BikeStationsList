//
//  NSMutableAttributedString+Ext.swift
//  BikeStationList
//
//  Created by Ceboolion on 10/05/2024.
//

import Foundation

extension NSMutableAttributedString {
    
    func addTexts(_ text: NSAttributedString...) {
        for i in text {
            append(i)
        }
    }
    
}
