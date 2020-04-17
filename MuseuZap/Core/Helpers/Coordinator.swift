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
protocol NavigationDelegate: class {
    func handleNavigation(action: Action)
}

protocol BaseCoordinator: Coordinator, NavigationDelegate {
    associatedtype T: UIViewController
    init(rootViewController: T)
    var rootViewController: T { get set }
    
}
