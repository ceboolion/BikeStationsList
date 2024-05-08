//
//  UIStackView+Ext.swift
//  BikeStationList
//
//  Created by Ceboolion on 08/05/2024.
//

import UIKit

extension UIStackView {
    func addSubviews(views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}

