//
//  MainViewModel.swift
//  BikeStationList
//
//  Created by Ceboolion on 08/05/2024.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

final class MainViewModel: BaseViewModel {
    
    //MARK: - PRIVATE PROPERTIES
    private let isDataLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    private let stationListServer = StationListServer()
    
    //MARK: - PUBLIC PROPERTIES
    let stationListData: BehaviorRelay<[StationListModel]> = BehaviorRelay(value: [])
    var userLocation: CLLocation? {
        didSet {
            if let userLocation, !stationListData.value.isEmpty {
                setDistanceForEachStation(for: userLocation)
            }
        }
    }
    
    var isSpinnerHiddenDriver: Driver<Bool> {
        isDataLoading
            .map { !$0 }
            .asDriver(onErrorJustReturn: true)
    }
    
    //MARK: - INIT
    override init() {
        super.init()
        getStationData()
    }
    
    //MARK: - PRIVATE METHODS
    private func getStationData() {
        isDataLoading.accept(true)
        let stationStatusDataUrl = "https://gbfs.urbansharing.com/rowermevo.pl/station_status.json"
        let stationListDataUrl = "https://gbfs.urbansharing.com/rowermevo.pl/station_information.json"
        Observable
            .zip(stationListServer.getStationStatus(urlString: stationStatusDataUrl),
                 stationListServer.getStationsList(urlString: stationListDataUrl))
            .subscribe(onNext: { [weak self] statusData, listData in
                self?.isDataLoading.accept(false)
                self?.setListData(with: statusData, stationListData: listData)
                if let userLocation = self?.userLocation {
                    self?.setDistanceForEachStation(for: userLocation)
                }
            }, onError: { [weak self] error in
                self?.isDataLoading.accept(false)
                print("error: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
    
    private func setListData(with statusData: StationStatusModel, stationListData: StationInformationModel) {
        var listData = convertStationListData(from: stationListData)
        listData = updateStationListData(with: statusData, dataToUpdate: listData)
        self.stationListData.accept(listData)
    }
    
    private func convertStationListData(from data: StationInformationModel) -> [StationListModel] {
        var convertedData = [StationListModel]()
        data.data?.stations?.forEach({ data in
            convertedData.append(StationListModel(stationId: data.stationId ?? "",
                                             placeName: data.name ?? "",
                                             placeAddress: data.address ?? "",
                                             vehiclesAvailability: "",
                                             placesAvailability: "",
                                             lat: data.lat ?? 0.0,
                                             lon: data.lon ?? 0.0))
        })
        return convertedData
    }
    
    private func updateStationListData(with data: StationStatusModel, dataToUpdate: [StationListModel]) -> [StationListModel] {
        var updatedData = dataToUpdate
        data.data?.stations?.forEach({ statusData in
            if let index = updatedData.firstIndex(where: {$0.stationId == statusData.stationId}) {
                updatedData[index].vehiclesAvailability = statusData.numVehiclesAvailable?.description ?? ""
                updatedData[index].placesAvailability = statusData.numDocksAvailable?.description ?? ""
            }
        })
        return updatedData
    }
    
    private func setDistanceForEachStation(for userLocalization: CLLocation) {
        var data = [StationListModel]()
        stationListData.value.forEach { model in
            let distance = calculateDistance(from: userLocalization, to: CLLocation(latitude: model.lat, longitude: model.lon))
            let formattedDistance = formatDistance(with: distance)
            let placeData = model.getDataWithDistance(distanceString: formattedDistance, distance: Double(distance))
            data.append(placeData)
        }
        let sortedData = sortStationList(for: data)
        stationListData.accept(sortedData)
    }
    
    private func sortStationList(for data: [StationListModel]) -> [StationListModel] {
        var sortedData = data
        sortedData.sort(by: { ($0.distance ?? 0.0) < ($1.distance ?? 0.0) })
        return sortedData
    }
    
    
}
