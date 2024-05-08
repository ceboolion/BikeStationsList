//
//  StationInformation.swift
//  BikeStationList
//
//  Created by Ceboolion on 08/05/2024.
//

import Foundation

struct StationInformationModel: Codable {
    let lastUpdated: Int?
    let ttl: Int?
    let version: String?
    let data: StationData?
    
    enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case ttl, version, data
    }
}

struct StationData: Codable {
    let stations: [StationInfo]?
}

struct StationInfo: Codable {
    let stationId: String?
    let name: String?
    let address: String?
    let crossStreet: String?
    let lat: Double?
    let lon: Double?
    let isVirtualStation: Bool?
    let capacity: Int?
//    let stationArea: StationArea?
    let rentalUris: RentalURIs?
    
    enum CodingKeys: String, CodingKey {
        case stationId = "station_id"
        case crossStreet = "cross_street"
        case isVirtualStation = "is_virtual_station"
//        case stationArea = "station_area"
        case rentalUris = "rental_uris"
        case name, address, lat, lon, capacity
    }
}

struct StationArea: Codable {
    let type: String?
//    let coordinates: [[Double]]?
    let coordinates: [[[Double]]]?
}

struct RentalURIs: Codable {
    let android: String?
    let ios: String?
}

