//
//  DetailViewModel.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 15/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit


protocol AboutViewModelProtocol {
    var navigationDelegate: NavigationDelegate? { get }
    var email: String { get set }
    var description: String { get set }
    func back()
    func sendEmail() throws
    init(email: String, description: String)
}

class AboutViewModel: AboutViewModelProtocol {
    weak var navigationDelegate: NavigationDelegate?
    var email: String
    var description: String
    
    required init(email: String, description: String) {
        self.email = email
        self.description = description
    }
    
    func back() {
        navigationDelegate?.handleNavigation(action: .back)
    }
    
    func sendEmail() throws{
        if let url = URL(string: "mailto:\(self.email)") {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
    }
}
