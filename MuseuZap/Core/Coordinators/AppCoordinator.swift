//
//  AppCoordinator.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 08/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class AppCoordinator: NSObject, Coordinator {
    
    private var coordinators = Stack<Coordinator>()
    
    var rootViewController: UITabBarController
    
    init(rootViewController: UITabBarController) {
        self.rootViewController = rootViewController
    }
    
    internal func startFlow() {
        UITabBar.appearance().tintColor = UIColor.Default.power
        let testCoordinator = ExploreCoordinator()
        testCoordinator.startFlow()
        let myAudiosCoordinator = MyAudiosCoordinator()
        myAudiosCoordinator.startFlow()
        let aboutCoordinator = AboutCoordinator()
        aboutCoordinator.startFlow()
        rootViewController.addChild(testCoordinator.rootViewController,
                                    myAudiosCoordinator.rootViewController,
                                    aboutCoordinator.rootViewController)
        coordinators.push(testCoordinator, myAudiosCoordinator, aboutCoordinator)

    }

}
