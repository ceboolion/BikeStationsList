//
//  StationListServer.swift
//  BikeStationList
//
//  Created by Ceboolion on 08/05/2024.
//

import Foundation
import RxSwift

class StationListServer: BaseServer {
    
    func getStationsList(urlString: String) -> Observable<StationInformationModel> {
        guard let url = URL(string: urlString) else { return Observable.error(NetworkError.invalidURL) }
        return netConnection.requestData(url)
    }
    
    func getStationStatus(urlString: String) -> Observable<StationStatusModel> {
        guard let url = URL(string: urlString) else { return Observable.error(NetworkError.invalidURL) }
        return netConnection.requestData(url)
    }
    
}
