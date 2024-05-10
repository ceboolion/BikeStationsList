//
//  ViewController.swift
//  BikeStationList
//
//  Created by Ceboolion on 08/05/2024.
//

import UIKit

class MainController: UIViewController {
    
    //MARK: - PUBLIC PROPERTIES
    var didSendEventClosure: ((Event)->Void)?
    
    //MARK: - PRIVATE PROPERTIES
    private var stationsListView: StationsListView!

    //MARK: - LIFECYCLE
    override func loadView() {
        super.loadView()
        configureStationsListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureConstraints()
    }
    
    //MARK: - PRIVATE METHODS
    private func setup() {
        view.backgroundColor = .primaryLightGray
        title = "Lista Stacji"
    }
    
    private func configureStationsListView() {
        stationsListView = StationsListView(viewModel: StationViewModel())
        stationsListView.didSendEventClosure = { [weak self] event in
            guard let self else { return }
            switch event {
            case .showMap(let data):
                self.didSendEventClosure?(.showMap(data))
            case .showAuthorizationAlert:
                self.didSendEventClosure?(.showAuthorizationAlert)
            }
        }
    }
    
    private func configureConstraints() {
        view.addSubview(stationsListView)
        
        stationsListView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }


}

//MARK: - EXTENSIONS
extension MainController {
    enum Event {
        case showMap(StationListModel)
        case showAuthorizationAlert
    }
}


