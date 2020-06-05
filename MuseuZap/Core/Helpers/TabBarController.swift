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
    lazy var currentViewController: UIViewController? = {
        return self.viewControllers?[self.selectedIndex]
    }()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.Default.regular.withSize(12)], for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UITabBarController {
    func addChild(_ controllers: UIViewController...) {
        for controller in controllers {
            self.addChild(controller)
        }
    }
}
