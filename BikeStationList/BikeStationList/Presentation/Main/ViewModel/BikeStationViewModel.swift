//
//  BikeStationViewModel.swift
//  BikeStationList
//
//  Created by Ceboolion on 10/05/2024.
//

import UIKit

class BikeStationViewModel {
    
    func getAttributedText(for distance: String, addressText: String) -> NSAttributedString {
        let finalText = NSMutableAttributedString()
        let boldFontAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: CustomFonts.manropeBold, size: 12)!,
            .foregroundColor: UIColor.primaryBlack
        ]
        let regularFontAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: CustomFonts.manropeRegular, size: 12)!,
            .foregroundColor: UIColor.primaryBlack
        ]
        let distanceToStation = NSMutableAttributedString(string: distance, attributes: boldFontAttribute)
        let spacerDot = NSMutableAttributedString(string: " · ", attributes: regularFontAttribute)
        let address = NSMutableAttributedString(string: addressText, attributes: regularFontAttribute)
        
        if distance == "" {
            return address
        } else {
            finalText.addTexts(distanceToStation, spacerDot, address)
        }
        return finalText
    }
    
    
}
