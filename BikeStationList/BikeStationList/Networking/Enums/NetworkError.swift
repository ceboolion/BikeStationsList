//
//  NetworkError.swift
//  BikeStationList
//
//  Created by Ceboolion on 08/05/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
