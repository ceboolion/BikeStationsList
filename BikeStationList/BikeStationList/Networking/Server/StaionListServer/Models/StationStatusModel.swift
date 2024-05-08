//
//  StationStatusModel.swift
//  BikeStationList
//
//  Created by Ceboolion on 08/05/2024.
//

import Foundation


struct StationStatusModel: Codable {
    let lastUpdated: Int?
    let ttl: Int?
    let version: String?
    let data: StationStatus?
    
    enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case ttl, version, data
    }
}

struct StationStatus: Codable {
    let stations: [StationStatusData]?
}

struct StationStatusData: Codable {
    let stationId: String?
    let isInstalled: Bool?
    let isRenting: Bool?
    let isReturning: Bool?
    let lastReported: Int?
    let numVehiclesAvailable: Int?
    let numBikesAvailable: Int?
    let numDocksAvailable: Int?
    let vehicleTypesAvailable: [VehicleType]?
    
    enum CodingKeys: String, CodingKey {
        case stationId = "station_id"
        case isInstalled = "is_installed"
        case isRenting = "is_renting"
        case isReturning = "is_returning"
        case lastReported = "last_reported"
        case numVehiclesAvailable = "num_vehicles_available"
        case numBikesAvailable = "num_bikes_available"
        case numDocksAvailable = "num_docks_available"
        case vehicleTypesAvailable = "vehicle_types_available"
    }
}

struct VehicleType: Codable {
    let vehicleTypeId: String?
    let count: Int?
    
    enum CodingKeys: String, CodingKey {
        case vehicleTypeId = "vehicle_type_id"
        case count
    }
}
