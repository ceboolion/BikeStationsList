//
//  UIView+Ext.swift
//  BikeStationList
//
//  Created by Ceboolion on 08/05/2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    func addShadow(with color: UIColor = .black, opacity: CFloat = 0.3) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: -1, height: 2)
        layer.shadowRadius = 1.8
        layer.shadowOpacity = opacity
      }
    
}
