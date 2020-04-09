//
//  AppCoordinator.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 08/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class AppCoordinator: NSObject,Coordinator {
    typealias T = UINavigationController
    
    private var coordinators = Stack<Coordinator>()
    
    var rootViewController: UINavigationController
    
    required init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    internal func startFlow() {
        // TODO
        let testCoordinator = TestCoordinator(rootViewController: rootViewController)
        testCoordinator.startFlow()
        coordinators.push(testCoordinator)
    }

}


