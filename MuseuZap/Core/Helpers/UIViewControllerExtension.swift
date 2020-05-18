//
//  UiViewControllerExtension.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 16/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import Firebase

protocol ViewController: UIViewController, NavigationDelegate {

    var delegate: NavigationDelegate? {get set}
    var screenName: String { get }
    dynamic func setScreenName() -> Bool

}

extension ViewController {

    @discardableResult
    func setScreenName() -> Bool {
        Analytics.setScreenName(self.screenName, screenClass: NSStringFromClass(Self.self))
        return true
    }

}
