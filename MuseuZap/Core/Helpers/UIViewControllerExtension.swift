//
//  UiViewControllerExtension.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 16/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

protocol ViewController: UIViewController, Delegatable {
    var delegate: Delegatable? {get set}
}
extension ViewController {
    func handleNavigation(action: Action) {
        delegate?.handleNavigation(action: action)
    }
}
