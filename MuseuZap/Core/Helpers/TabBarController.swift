//
//  TabBarController.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 24/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation
import UIKit

class TabBar: UITabBarController {
    // Player customization will be here someday
}

extension UITabBarController {
    func addChild(_ controllers: UIViewController...) {
        for controller in controllers {
            self.addChild(controller)
        }
    }
}
