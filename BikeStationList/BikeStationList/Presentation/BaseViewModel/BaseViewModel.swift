//
//  BaseViewModel.swift
//  BikeStationList
//
//  Created by Ceboolion on 08/05/2024.
//

import Foundation
import RxSwift
import CoreLocation

class BaseViewModel {
    
    //MARK: - PUBLIC PROPERTIES
    let disposeBag = DisposeBag()
    
    func setLocationCoordinates(from coordinates: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinates.latitude,
                               longitude: coordinates.longitude)
    }
    
    func calculateDistance(from: CLLocation, to: CLLocation) -> CLLocationDistance {
        from.distance(from: to)
    }
    
    func formatDistance(with distance: CLLocationDistance) -> String {
        let meters = Measurement(value: distance, unit: UnitLength.meters)
        return meters.converted(to: .kilometers).formatted()
    }
    
    func getPlaceDataWithDistance(from: CLLocationCoordinate2D?, to: CLLocationCoordinate2D?, data: StationListModel) -> StationListModel {
        guard let from, let to else { return data }
        let start = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let end = CLLocation(latitude: to.latitude, longitude: to.longitude)
        let distance = calculateDistance(from: start, to: end)
        let data = data.getDataWithDistance(distanceString: formatDistance(with: distance))
        return data
    }
    
}
