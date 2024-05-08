//
//  StationViewModel.swift
//  BikeStationList
//
//  Created by Ceboolion on 08/05/2024.
//

import Foundation
import RxSwift
import RxCocoa

final class StationViewModel: BaseViewModel {
    
    //MARK: - PRIVATE PROPERTIES
    private let isDataLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    //MARK: - PUBLIC PROPERTIES
    let stationListData: BehaviorRelay<[StationListModel]> = BehaviorRelay(value: [])
    var isSpinnerHiddenDriver: Driver<Bool> {
        isDataLoading
            .map { !$0 }
            .asDriver(onErrorJustReturn: true)
    }
    
    //MARK: - PRIVATE PROPERTIES
    private let stationListServer = StationListServer()
    
    override init() {
        super.init()
        getStationData()
        stationListData.accept(dummyData)
    }
    
    private func getStationData() {
        isDataLoading.accept(true)
        let stationStatusDataUrl = "https://gbfs.urbansharing.com/rowermevo.pl/station_status.json"
        let stationListDataUrl = "https://gbfs.urbansharing.com/rowermevo.pl/station_information.json"
        Observable
            .zip(stationListServer.getStationStatus(urlString: stationStatusDataUrl),
                 stationListServer.getStationsList(urlString: stationListDataUrl))
            .subscribe(onNext: { [weak self] statusData, listData in
                self?.isDataLoading.accept(false)
                print("WRC statusData: \(statusData), stations.count: \(statusData.data?.stations?.count)")
                print("WRC listData: \(listData), stations.count: \(listData.data?.stations?.count)")
            }, onError: { [weak self] error in
                self?.isDataLoading.accept(false)
                print("WRC error: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
}

let dummyData: [StationListModel] = [
    StationListModel(stationId: "4971", placeName: "GDA370", placeAddress: "Lawendowe wzgórze", vehiclesAvailability: "0", placesAvailability: "10", lat: 54.3272251, lon: 18.5602068),
    StationListModel(stationId: "4972", placeName: "GDA371", placeAddress: "GDA371 Address", vehiclesAvailability: "2", placesAvailability: "8", lat: 54.3272252, lon: 18.5602069),
    StationListModel(stationId: "4973", placeName: "GDA372", placeAddress: "GDA372 Address", vehiclesAvailability: "5", placesAvailability: "5", lat: 54.3272253, lon: 18.5602070),
    StationListModel(stationId: "4974", placeName: "GDA373", placeAddress: "GDA373 Address", vehiclesAvailability: "8", placesAvailability: "2", lat: 54.3272254, lon: 18.5602071),
    StationListModel(stationId: "4975", placeName: "GDA374", placeAddress: "GDA374 Address", vehiclesAvailability: "10", placesAvailability: "0", lat: 54.3272255, lon: 18.5602072),
    StationListModel(stationId: "4976", placeName: "GDA375", placeAddress: "GDA375 Address", vehiclesAvailability: "3", placesAvailability: "7", lat: 54.3272256, lon: 18.5602073),
    StationListModel(stationId: "4977", placeName: "GDA376", placeAddress: "GDA376 Address", vehiclesAvailability: "6", placesAvailability: "4", lat: 54.3272257, lon: 18.5602074),
    StationListModel(stationId: "4978", placeName: "GDA377", placeAddress: "GDA377 Address", vehiclesAvailability: "9", placesAvailability: "1", lat: 54.3272258, lon: 18.5602075),
    StationListModel(stationId: "4979", placeName: "GDA378", placeAddress: "GDA378 Address", vehiclesAvailability: "1", placesAvailability: "9", lat: 54.3272259, lon: 18.5602076),
    StationListModel(stationId: "4980", placeName: "GDA379", placeAddress: "GDA379 Address", vehiclesAvailability: "4", placesAvailability: "6", lat: 54.3272260, lon: 18.5602077)
]
