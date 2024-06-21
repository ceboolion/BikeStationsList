//
//  AvailabilityViewType.swift
//  BikeStationList
//
//  Created by Ceboolion on 08/05/2024.
//

import UIKit

enum AvailabilityViewType {
    case bike
    case place
    
    var image: UIImage {
        switch self {
        case .bike:
            UIImage(resource: .bike)
        case .place:
            UIImage(resource: .lock)
        }
    }
    
    var title: String {
        switch self {
        case .bike:
            "Bikes available"
        case .place:
            "Places available"
        }
    }
}
