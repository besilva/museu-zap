//
//  Coordinator.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 08/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

protocol Coordinator {
    func startFlow()
}

enum Action {
    case back
}

protocol BaseCoordinator: Coordinator {
    associatedtype T: UIViewController
    init(rootViewController: T)
    var rootViewController: T { get set }
    func handleNavigation(action: Action)
}
