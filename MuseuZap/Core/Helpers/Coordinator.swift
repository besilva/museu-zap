//
//  Coordinator.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 08/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import DatabaseKit

protocol Coordinator {
    func startFlow()
}

enum Action {
    case back
    case about
    case presentAlert(String?, String?, Double?, UIAlertController.Style)
    case share(String)
    case play(String, ((Error?) -> Void))
    case category(AudioCategory)
}
protocol NavigationDelegate: class {
    func handleNavigation(action: Action)
}

protocol BaseCoordinator: Coordinator, NavigationDelegate {
    associatedtype T: UIViewController
    var rootViewController: T { get set }
    var appCoordinatorDelegate: AppCoordinatorDelegate? { get set }
}
