//
//  StationListModel.swift
//  BikeStationList
//
//  Created by Ceboolion on 08/05/2024.
//

import Foundation

struct StationListModel {
    var stationId: String
    var placeName: String
    var placeAddress: String
    var vehiclesAvailability: String
    var placesAvailability: String
    var lat: Double
    var lon: Double
    var distance: Double?
    var distanceFromUser: String?
    
    func getDataWithDistance(distanceString: String, distance: Double = 0.0) -> StationListModel {
        StationListModel(stationId: stationId, placeName: placeName, placeAddress: placeAddress, vehiclesAvailability: vehiclesAvailability, placesAvailability: placesAvailability, lat: lat, lon: lon, distance: distance, distanceFromUser: distanceString)
    }
}
