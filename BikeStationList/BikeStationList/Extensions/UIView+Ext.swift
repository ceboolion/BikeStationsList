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
}
