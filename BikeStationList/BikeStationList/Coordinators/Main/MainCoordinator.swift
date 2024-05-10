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
            case .showMap(let data):
                self.showMapView(with: data)
            case .showAuthorizationAlert:
                self.showAuthorizationAlert()
            }
        }
        setMainController(with: controller)
    }
    
    //MARK: - PRIVATE METHODS
    private func showMapView(with data: StationListModel) {
        let controller = MapController()
        controller.setBikeStationData(with: data)
        controller.didSendEventClosure = { [weak self] event in
            guard let self else { return }
            switch event {
            case .showSheet(let data):
                self.presentPlaceInfoSheet(with: data)
            case .showAuthorizationAlert:
                self.showAuthorizationAlert()
            }
        }
        push(controller)
    }
    
    private func presentPlaceInfoSheet(with stationData: StationListModel?) {
        guard let stationData else { return }
        let controller = PlaceInformationController()
        controller.setSheetViewData(with: stationData)
        if let sheet = controller.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.detents = [.custom { _ in
                return 232
            }]
        }
        present(controller)
    }
    
    private func showAuthorizationAlert() {
        let alertController = UIAlertController (title: "Udostępnij swoją lokalizację", 
                                                 message: "Jeżeli chcesz korzystać z mapy, zmień ustawienia aplikacji.",
                                                 preferredStyle: .alert)
        let openSetting = UIAlertAction(title: "Ustawienia", style: .default) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(openSetting)
        let cancelAction = UIAlertAction(title: "Anuluj", style: .destructive)
        alertController.addAction(cancelAction)
        presentOnTopController(alertController)
    }
    
    private func setMainController(with controller: UIViewController) {
        navigationController.setViewControllers([controller], animated: false)
    }
    
    private func push(_ controller: UIViewController) {
        navigationController.pushViewController(controller, animated: true)
    }
    
    private func present(_ controller: UIViewController) {
        navigationController.present(controller, animated: true)
    }
    
    private func presentOnTopController(_ controller: UIViewController) {
        navigationController.topViewController?.present(controller, animated: true)
    }
    
}

