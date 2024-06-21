//
//  BikeStationView.swift
//  BikeStationList
//
//  Created by Ceboolion on 09/05/2024.
//

import UIKit

class BikeStationView: UIView {
    
    //MARK: - PRIVATE PROPERTIES
    private let viewModel = BikeStationViewModel()
    private var stationNameLabel: UILabel!
    private var addressLabel: UILabel!
    private var vehicleView: AvailabilityView!
    private var placeView: AvailabilityView!
    private var stackView: UIStackView!
    private let padding: CGFloat = CustomProperties.defaultPadding
    private let offset: CGFloat = 4.0
    
    //MARK: - OVERRIDDEN METHODS
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - PUBLIC METHODS
    func setView(with data: StationListModel) {
        setStationNameLabel(text: data.placeName)
        setAddressLabel(text: data.placeAddress, distance: data.distanceFromUser ?? "")
        setVehicleView(availabilityNumber: data.vehiclesAvailability)
        setPlacesView(availabilityNumber: data.placesAvailability)
    }
    
    //MARK: - PRIVATE METHODS
    private func configureUI() {
        configureViewUI()
        configureStationNameLabel()
        configureAddressLabel()
        configureVehicleView()
        configurePlaceView()
        configureStackView()
        configureConstraints()
    }
    
    private func configureViewUI() {
        backgroundColor = .white
        layer.cornerRadius = 16
    }
    
    private func configureStationNameLabel() {
        stationNameLabel = .init()
        stationNameLabel.font = UIFont(name: CustomFonts.manropeSemiBold, size: 24)
        stationNameLabel.textAlignment = .left
        stationNameLabel.textColor = .primaryBlack
    }
    
    private func configureAddressLabel() {
        addressLabel = .init()
        addressLabel.font = UIFont(name: CustomFonts.manropeRegular, size: 12)
        addressLabel.textAlignment = .left
        addressLabel.textColor = .primaryBlack
    }
    
    private func configureVehicleView() {
        vehicleView = .init()
    }
    
    private func configurePlaceView() {
        placeView = .init()
    }
    
    private func configureStackView() {
        stackView = .init()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        stackView.addSubviews(views: vehicleView, placeView)
    }
    
    private func configureConstraints() {
        addSubviews(stationNameLabel, addressLabel, stackView)
        
        stationNameLabel.snp.makeConstraints {
            $0.top.leading.equalTo(padding)
            $0.trailing.equalTo(-padding)
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(stationNameLabel.snp.bottom).offset(offset)
            $0.leading.equalTo(padding)
            $0.trailing.equalTo(-padding)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(20)
            $0.leading.equalTo(padding)
            $0.bottom.trailing.equalTo(-padding)
            $0.height.equalTo(104)
        }
    }
    
    private func setStationNameLabel(text: String) {
        stationNameLabel.text = text
    }
    
    private func setAddressLabel(text: String, distance: String) {
        addressLabel.attributedText = viewModel.getAttributedText(for: distance, addressText: text)
    }
    
    private func setVehicleView(availabilityNumber: String) {
        vehicleView.setupView(viewType: .bike, availabilityNumber: availabilityNumber)
    }
    
    private func setPlacesView(availabilityNumber: String) {
        placeView.setupView(viewType: .place, availabilityNumber: availabilityNumber)
    }
    
    
}
