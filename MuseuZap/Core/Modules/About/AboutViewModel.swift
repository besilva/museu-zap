//
//  DetailViewModel.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 15/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

protocol AboutViewModelDelegate: class {
    func handleTap()
}

protocol AboutViewModelProtocol {
    var navigationDelegate: NavigationDelegate? { get }
    var delegate: AboutViewModelDelegate? { get set }
    var email: String { get set }
    var description: String { get set }
    func back()
    init(email: String, description: String)
}

class AboutViewModel: AboutViewModelProtocol {
    weak var navigationDelegate: NavigationDelegate?
    var email: String = "foo@bar.com"
    var description: String = "App description"
    weak var delegate: AboutViewModelDelegate?
    
    required init(email: String, description: String) {
        self.email = email
        self.description = description
    }
    
    func back() {
        navigationDelegate?.handleNavigation(action: .back)
    }
}
