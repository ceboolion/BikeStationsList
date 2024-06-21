//
//  UITableViewCell+Ext.swift
//  BikeStationList
//
//  Created by Ceboolion on 08/05/2024.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
