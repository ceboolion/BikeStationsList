//
//  BikeStationViewCell.swift
//  BikeStationList
//
//  Created by Ceboolion on 08/05/2024.
//

import UIKit

class BikeStationViewCell: UITableViewCell {
    
    //MARK: - PRIVATE PROPERTIES
    private var bikeStationView: BikeStationView!
    private var topPadding: CGFloat = 8.0
    
    //MARK: - OVERRIDDEN METHODS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - PUBLIC METHODS
    func setCell(with data: StationListModel) {
        bikeStationView.setView(with: data)
    }
    
    //MARK: - PRIVATE METHODS
    private func configureCell() {
        accessoryType = .none
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    private func configureUI() {
        configureBikeStationView()
        configureConstraints()
    }
    
    private func configureBikeStationView() {
        bikeStationView = .init()
    }
    
    private func configureConstraints() {
        contentView.addSubview(bikeStationView)
        
        bikeStationView.snp.makeConstraints {
            $0.top.equalTo(topPadding)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }

    
}
