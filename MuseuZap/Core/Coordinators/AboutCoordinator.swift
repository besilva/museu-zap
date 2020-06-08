//
//  DetailCoordinator.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 15/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class AboutCoordinator: BaseCoordinator {

    var rootViewController: UIViewController
    weak var appCoordinatorDelegate: AppCoordinatorDelegate?

    init(rootViewController: UIViewController = UIViewController()) {
        self.rootViewController = rootViewController
    }
    
    func startFlow() {
        let navController = UINavigationController()
        let aboutController = AboutViewController()
        aboutController.delegate = self
        navController.modalPresentationStyle = .fullScreen
        navController.pushViewController(aboutController, animated: false)
        self.rootViewController.present(navController, animated: true)
    }

    func handleNavigation(action: Action) {
        switch action {
        case .back:
            self.appCoordinatorDelegate?.handleAppNavigation(action: .back)
            self.rootViewController.dismiss(animated: true)
        default:
            break
        }
    }
}
