//
//  DetailCoordinator.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 15/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class AboutCoordinator: BaseCoordinator {
    typealias T = UINavigationController
    var rootViewController: UINavigationController
    
    required init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func startFlow() {
        let aboutController = AboutViewController()
        let viewModel = AboutViewModel()
        aboutController.viewModel = viewModel
        self.rootViewController.pushViewController(aboutController, animated: true)
    }
}
