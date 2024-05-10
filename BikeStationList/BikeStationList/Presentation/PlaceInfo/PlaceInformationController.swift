//
//  PlaceInformationController.swift
//  BikeStationList
//
//  Created by Ceboolion on 09/05/2024.
//

import UIKit
import SnapKit

class PlaceInformationController: UIViewController {
    
    //MARK: - PRIVATE PROPERTIES
    private var bikeStationView = BikeStationView()
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureConstraints()
    }
    
    //MARK: - PUBLIC METHODS
    func setSheetViewData(with data: StationListModel) {
        bikeStationView.setView(with: data)
    }

    //MARK: - PRIVATE METHODS
    private func configureConstraints() {
        view.addSubview(bikeStationView)
        
        bikeStationView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.centerY.equalTo(view.snp.centerY)
            $0.top.greaterThanOrEqualTo(view.snp.top)
            $0.bottom.lessThanOrEqualTo(view.snp.bottom)
        }
    }
    
    
}
