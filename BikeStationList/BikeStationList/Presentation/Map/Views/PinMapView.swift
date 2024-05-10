//
//  PinMapView.swift
//  BikeStationList
//
//  Created by Ceboolion on 09/05/2024.
//

import UIKit

class PinMapView: UIView {
    
    //MARK: - PRIVATE PROPERTIES
    private var vehiclesNumberLabel: UILabel!
    private var iconImageView: UIImageView!
    private var stackView: UIStackView!
    private let viewHeight: CGFloat = 24

    //MARK: - OVERRIDDEN METHODS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - PUBLIC METHODS
    func setVehiclesNumberLabel(text: String) {
        vehiclesNumberLabel.text = text
    }
    
    //MARK: - PRIVATE METHODS
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = viewHeight / 2
        configureVehiclesNumberLabel()
        configureIconImageView()
        configureStackView()
        configureConstraints()
    }
    
    private func configureVehiclesNumberLabel() {
        vehiclesNumberLabel = .init()
        vehiclesNumberLabel.textAlignment = .center
        vehiclesNumberLabel.font = UIFont(name: CustomFonts.manropeSemiBold, size: 18)
        vehiclesNumberLabel.textColor = .primaryBlack
    }
    
    private func configureIconImageView() {
        iconImageView = .init()
        let image = UIImage(systemName: "bicycle")?.withConfiguration(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 15, weight: .regular))).withTintColor(.primaryBlack).withRenderingMode(.alwaysOriginal)
        iconImageView.image = image
    }
    
    private func configureStackView() {
        stackView = .init()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.addSubviews(views: vehiclesNumberLabel, iconImageView)
    }
    
    private func configureConstraints() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5))
            $0.height.equalToSuperview()
        }
    }
    
    
}
