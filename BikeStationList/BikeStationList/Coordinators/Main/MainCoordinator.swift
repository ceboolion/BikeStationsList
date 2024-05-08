//
//  MainCoordinator.swift
//  BikeStationList
//
//  Created by Ceboolion on 08/05/2024.
//

import UIKit

final class MainCoordinator: NSObject, Coordinator {
    
    //MARK: - PUBLIC PROPERTIES
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .main }
    
    // MARK: - INITIALIZER
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        start()
    }
    
    //MARK: - PUBLIC METHODS
    func start() {
        let controller = MainController()
        controller.didSendEventClosure = { [weak self] event in
            guard let self else { return }
            switch event {
            case .showMap(let mapData):
                self.showMapView(with: mapData)
            }
        }
        setMainController(with: controller)
    }
    
    //MARK: - PRIVATE METHODS
    private func showMapView(with mapData: StationListModel) {
        let controller = UIViewController()
        controller.view.backgroundColor = .red
        push(controller)
    }
    
    private func setMainController(with controller: UIViewController) {
        navigationController.setViewControllers([controller], animated: false)
    }
    
    private func push(_ controller: UIViewController) {
        navigationController.pushViewController(controller, animated: true)
    }
    
}
