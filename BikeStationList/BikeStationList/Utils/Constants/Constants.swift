//
//  Constants.swift
//  BikeStationList
//
//  Created by Ceboolion on 08/05/2024.
//

import UIKit

// MARK: - FONTS
struct CustomFonts {
    static let manropeRegular = "Manrope-Regular"
    static let manropeExtraLight = "Manrope-ExtraLight"
    static let manropeLight = "Manrope-Light"
    static let manropeSemiBold = "Manrope-SemiBold"
    static let manropeBold = "Manrope-Bold"
    static let manropeExtraBold = "Manrope-ExtraBold"
}

// MARK: - PROPERTIES
struct CustomProperties {
    static let defaultPadding: CGFloat = 16.0
}

// MARK: IMAGES
struct CustomImages {
    static let infoImage = UIImage(systemName: "info.circle.fill",
                             withConfiguration:
                               UIImage.SymbolConfiguration(weight: .regular))?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(paletteColors: [
                                   .white,
                                   .accent]))
    
    static let bicycleImage = UIImage(systemName: "bicycle")?.withConfiguration(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 15, weight: .regular))).withTintColor(.primaryBlack).withRenderingMode(.alwaysOriginal)
}
