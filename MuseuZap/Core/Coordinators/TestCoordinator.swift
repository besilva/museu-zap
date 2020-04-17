//
//  TestCoordinator.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 08/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class TestCoordinator: BaseCoordinator {
    
    typealias T = UINavigationController
    var rootViewController: UINavigationController
    
    required init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func startFlow() {
        let listController = ListViewController()
        listController.delegate = self
        self.rootViewController.pushViewController(listController, animated: true)
    }
    
    func handleNavigation(action: Action) {
        switch action {
        case .back:
            self.rootViewController.dismiss(animated: true)
        }
    }
    
}
