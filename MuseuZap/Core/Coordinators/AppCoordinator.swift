//
//  AppCoordinator.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 08/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

protocol AppCoordinatorDelegate: class {
    func handleAppNavigation(action: Action)
}

class AppCoordinator: NSObject, Coordinator {
    
    private var coordinators = Stack<Coordinator>()
    
    weak var appCoordinatorDelegate: AppCoordinatorDelegate?
    
    var rootViewController: UITabBarController
    
    init(rootViewController: UITabBarController) {
        self.rootViewController = rootViewController
    }
    
    internal func startFlow() {
        UITabBar.appearance().tintColor = UIColor.Default.power
        let exploreCoordinator = ExploreCoordinator()
        exploreCoordinator.appCoordinatorDelegate = self
        exploreCoordinator.startFlow()
        let myAudiosCoordinator = MyAudiosCoordinator()
        myAudiosCoordinator.appCoordinatorDelegate = self
        myAudiosCoordinator.startFlow()
        rootViewController.addChild(exploreCoordinator.rootViewController,
                                    myAudiosCoordinator.rootViewController)
        coordinators.push(exploreCoordinator, myAudiosCoordinator)
    }

}

extension AppCoordinator: AppCoordinatorDelegate {
    func handleAppNavigation(action: Action) {
        switch action {
        case .about:
            let aboutCoordinator = AboutCoordinator(rootViewController: self.rootViewController)
            aboutCoordinator.appCoordinatorDelegate = self
            aboutCoordinator.startFlow()
            coordinators.push(aboutCoordinator)
        case .back:
            coordinators.pop()
        default:
            print("Invalid app navigation!")
            return
        }
        
    }
}
