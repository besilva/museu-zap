//
//  UiViewControllerExtension.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 16/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

protocol ViewController: UIViewController, NavigationDelegate {
    var delegate: NavigationDelegate? {get set}
}
extension ViewController {
    func handleNavigation(action: Action) {
        delegate?.handleNavigation(action: action)
    }
}
