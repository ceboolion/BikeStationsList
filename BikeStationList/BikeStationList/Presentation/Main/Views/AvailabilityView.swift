//
//  AvailabilityView.swift
//  BikeStationList
//
//  Created by Ceboolion on 08/05/2024.
//

import UIKit

class AvailabilityView: UIView {
    
    //MARK: - PRIVATE PROPERTIES
    private var iconImageView: UIImageView!
    private var availabilityNumberLabel: UILabel!
    private var nameLabel: UILabel!
    private var stackView: UIStackView!
    
    //MARK: - OVERRIDDEN METHODS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - PUBLIC METHODS
    func setupView(viewType: AvailabilityViewType, availabilityNumber: String) {
        setImageView(image: viewType.image)
        setAvailabilityNumberLabel(text: availabilityNumber, viewType: viewType)
        setNameLabel(text: viewType.title)
    }
    
    //MARK: - PRIVATE METHODS
    private func setupUI() {
        configureIconImage()
        configureAvailabilityNumberLabel()
        configureNameLabel()
        configureStackView()
        configureConstraints()
    }
    
    private func configureIconImage() {
        iconImageView = .init()
        iconImageView.contentMode = .scaleAspectFit
    }
    
    private func configureAvailabilityNumberLabel() {
        availabilityNumberLabel = .init()
        availabilityNumberLabel.textAlignment = .center
        availabilityNumberLabel.font = UIFont(name: CustomFonts.manropeExtraBold, size: 44)
    }
    
    private func configureNameLabel() {
        nameLabel = .init()
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: CustomFonts.manropeRegular, size: 12)
        nameLabel.textColor = .primaryBlack
    }
    
    private func configureStackView() {
        stackView = .init()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.distribution = .fill
        stackView.addSubviews(views: iconImageView, availabilityNumberLabel, nameLabel)
    }
    
    private func setImageView(image: UIImage) {
        iconImageView.image = image
    }
    
    private func setNameLabel(text: String) {
        nameLabel.text = text
    }
    
    private func setAvailabilityNumberLabel(text: String, viewType: AvailabilityViewType) {
        availabilityNumberLabel.text = text
        availabilityNumberLabel.textColor = setLabelTextColor(for: viewType, text: text)
    }
    
    private func configureConstraints() {
        addSubview(stackView)
        
        iconImageView.snp.makeConstraints {
            $0.height.width.equalTo(24)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(104)
        }
    }
    
    private func setLabelTextColor(for viewType: AvailabilityViewType, text: String) -> UIColor {
        viewType == .bike ? (text == "0" ? .lightGray : .customGreen) : .primaryBlack
    }
    
    
}
