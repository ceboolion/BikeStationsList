//
//  MapController.swift
//  BikeStationList
//
//  Created by Ceboolion on 09/05/2024.
//

import UIKit
import MapKit
import CoreLocation
import SnapKit
import RxSwift

class MapController: UIViewController {
    
    //MARK: - PUBLIC PROPERTIES
    var didSendEventClosure: ((Event)->Void)?
    
    //MARK: - PRIVATE PROPERTIES
    private var viewModel = MapViewModel()
    private var stationPlaceData: StationListModel?
    private var mapView: MainMapView!
    
    //MARK: - LIFECYCLE
    override func loadView() {
        super.loadView()
        configureMapView()
        title = stationPlaceData?.placeName ?? ""
        navigationController?.navigationBar.tintColor = .primaryLightGray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let stationPlaceData else { return }
        didSendEventClosure?(.showSheet(stationPlaceData))
    }
    
    //MARK: - PUBLIC METHODS
    func setBikeStationData(with data: StationListModel) {
        stationPlaceData = data
    }
    
    //MARK: - PRIVATE METHODS
    private func configureMapView() {
        guard let stationPlaceData else { return }
        mapView = MainMapView(stationPlaceData: stationPlaceData)
        mapView.eventClosure = { [weak self] event in
            switch event {
            case .showInfoSheet(let placeData):
                self?.didSendEventClosure?(.showSheet(placeData))
            case .showAuthorizationAlert:
                self?.didSendEventClosure?(.showAuthorizationAlert)
            }
        }
    }
    
    private func configureConstraints() {
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
}

//MARK: - EXTENSIONS
extension MapController {
    enum Event {
        case showSheet(StationListModel)
        case showAuthorizationAlert
    }
}
