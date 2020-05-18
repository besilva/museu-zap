//
//  AppDelegateFake.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 15/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class AppDelegateFake: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let viewController = UIViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = viewController
        self.window = window
        window.makeKeyAndVisible()

        return true
    }
}
