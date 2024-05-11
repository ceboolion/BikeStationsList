//
//  MapView.swift
//  BikeStationList
//
//  Created by Ceboolion on 09/05/2024.
//

import UIKit
import MapKit
import CoreLocation
import SnapKit
import RxSwift

class MainMapView: UIView {
    
    //MARK: - PUBLIC PROPERTIES
    var eventClosure: ((Event)->Void)?
    
    //MARK: - PRIVATE PROPERTIES
    private var viewModel = MapViewModel()
    private var routeCoordinates : [CLLocation] = []
    private var routeOverlay : MKOverlay?
    private var locationManager: CLLocationManager!
    private var mapView: MKMapView!
    private var stationPlaceData: StationListModel?
    private var customAnnotationView: CustomAnnotationView!
    private var infoSheetButton: UIButton!

    // MARK: - INIT
    init(stationPlaceData: StationListModel) {
        self.stationPlaceData = stationPlaceData
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - PRIVATE METHODS
    private func configure() {
        configureLocationManager()
        configureMapView()
        configureInfoSheetButton()
        configureConstraints()
        setupObservables()
        addCustomPin()
        setRoutesCoordinates()
    }
    
    private func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    private func configureMapView() {
        mapView = .init()
        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: "custom")
    }
    
    private func configureInfoSheetButton() {
        infoSheetButton = .init(type: .system)
        infoSheetButton.setImage(CustomImages.infoImage, for: .normal)
        infoSheetButton.setImage(CustomImages.infoImage, for: .highlighted)
        infoSheetButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 40), forImageIn: .normal)
        infoSheetButton.addShadow()
    }
    
    private func configureConstraints() {
        addSubviews(mapView, infoSheetButton)
        
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        infoSheetButton.snp.makeConstraints {
            $0.bottom.trailing.equalTo(-30)
            $0.width.height.equalTo(50)
        }
    }
    
    private func addCustomPin() {
        configureCustomAnnotationView()
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: stationPlaceData?.lat ?? 0.0,
                                                       longitude: stationPlaceData?.lon ?? 0.0)
        mapView.addAnnotation(annotation)
    }
    
    private func configureCustomAnnotationView() {
        customAnnotationView = .init()
    }
    
    private func setRegion(for location: CLLocation) {
        let currentRegion = MKCoordinateRegion(center: location.coordinate,
                                               latitudinalMeters: 700,
                                               longitudinalMeters: 700)
        mapView.setRegion(currentRegion, animated: true)
    }
    
    private func setRoutesCoordinates() {
        guard let userCoordinates = locationManager.location, let stationLocation = stationPlaceData else { return }
        let startPoint = CLLocation(latitude: userCoordinates.coordinate.latitude,
                                                longitude: userCoordinates.coordinate.longitude)
        let endPoint = CLLocation(latitude: stationLocation.lat,
                                              longitude: stationLocation.lon)
        routeCoordinates.append(startPoint)
        routeCoordinates.append(endPoint)
    }
    
    private func drawRoute(routeData: [CLLocation]) {
        if routeData.count == 0 {
            print("No Coordinates to draw")
            return
        }
        let inset: CGFloat = 80
        guard let startPoint = routeData.first?.coordinate, let destination = routeData.last?.coordinate else { return }
        let start = viewModel.setLocationCoordinates(from: startPoint)
        let end = viewModel.setLocationCoordinates(from: destination)
        let sourcePlacemark = MKPlacemark(coordinate: start)
        let destinationPlacemark = MKPlacemark(coordinate: end)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlacemark)
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        directionRequest.transportType = .walking
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { [weak self] response, error in
            guard let directionsResponse = response, !directionsResponse.routes.isEmpty else {
                if let error {
                    print("directionsResponse error: \(error.localizedDescription)")
                }
                return
            }
            let route = directionsResponse.routes[0]
            self?.mapView.addOverlay(route.polyline, level: .aboveRoads)
            let rect = route.polyline.boundingMapRect
            self?.mapView.setVisibleMapRect(rect,
                                            edgePadding: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset),
                                            animated: true)
        }
    }
    
    //MARK: - RX
    private func setupObservables() {
        bindInfoSheetButton()
    }
    
    private func bindInfoSheetButton() {
        infoSheetButton
            .rx
            .tap
            .bind { [weak self] in
                guard let data = self?.stationPlaceData else { return }
                if let placeData = self?.viewModel.getPlaceDataWithDistance(from: self?.routeCoordinates.first?.coordinate,
                                                                            to: self?.routeCoordinates.last?.coordinate,
                                                                            data: data) {
                    self?.eventClosure?(.showInfoSheet(placeData))
                }
            }
            .disposed(by: viewModel.disposeBag)
    }
    
    
}

//MARK: - EXTENSIONS
extension MainMapView: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom") as? CustomAnnotationView
        if annotationView == nil {
            let customView = CustomAnnotationView()
            customView.setLabelText(with: stationPlaceData?.vehiclesAvailability ?? " - ")
            return customView
        } else {
            annotationView?.setLabelText(with: stationPlaceData?.vehiclesAvailability ?? " - ")
            annotationView?.annotation = annotation
            annotationView?.canShowCallout = true
            return annotationView
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else { fatalError("Not a MKPolyline") }
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.lineCap = .square
        renderer.strokeColor = UIColor.customRoute
        renderer.lineWidth = 1.5
        renderer.lineDashPattern = [3, 6]
        return renderer
    }
    
    
}

extension MainMapView: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {}
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {}
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization(manager: manager)
    }
    
    private func checkLocationAuthorization(manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            setRegion(for: CLLocation(latitude: stationPlaceData?.lat ?? 0.0, longitude: stationPlaceData?.lon ?? 0.0))
            drawRoute(routeData: routeCoordinates)
        case .notDetermined:
            print("location notDetermined")
        case .restricted, .denied:
            eventClosure?(.showAuthorizationAlert)
        @unknown default:
            print("alert unable to get location")
        }
    }
    
    
}

extension MainMapView {
    enum Event {
        case showInfoSheet(StationListModel)
        case showAuthorizationAlert
    }
}
