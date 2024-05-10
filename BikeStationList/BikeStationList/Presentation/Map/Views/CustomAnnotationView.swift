//
//  CustomAnnotationView.swift
//  BikeStationList
//
//  Created by Ceboolion on 09/05/2024.
//

import UIKit
import MapKit
import SnapKit

class CustomAnnotationView: MKAnnotationView {
    
    //MARK: - PRIVATE PROPERTIES
    private var pinView: PinMapView!
    private var vehicleQuantity: String = ""
    
    //MARK: - OVERRIDDEN METHODS
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        frame = CGRect(x: 0, y: 0, width: 60, height: 28)
        centerOffset = CGPoint(x: -30, y: -frame.size.height / 2)
        canShowCallout = true
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - PUBLIC METHODS
    func setLabelText(with text: String) {
        pinView.setVehiclesNumberLabel(text: text)
    }
    
    //MARK: - PRIVATE METHODS
    private func setupUI() {
        backgroundColor = .clear
        configurePinView()
        configureConstraints()
    }
    
    private func configurePinView() {
        pinView = PinMapView()
        pinView.frame = CGRect(x: 0, y: 0, width: 60, height: 28)
        pinView.layer.shadowColor = UIColor.customGreen.cgColor
        pinView.layer.shadowOpacity = 1
        pinView.layer.shadowOffset = .zero
        pinView.layer.shadowRadius = 5
    }
    
    private func configureConstraints() {
        addSubview(pinView)
    }
    
    
}
