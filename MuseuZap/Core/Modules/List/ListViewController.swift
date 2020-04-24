//
//  ListViewController.swift
//  MVVM-POC
//
//  Created by Bernardo Silva on 01/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, ViewController, NavigationDelegate {
    func handleNavigation(action: Action) {
        return
    }
    
    weak var delegate: NavigationDelegate?

    private var myView: ListView {
        // swiftlint:disable force_cast
        return view as! ListView
    }
 
    override func loadView() {
        let myView = ListView()
        view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List"
        // Fake doing request
        let testeServices = TesteServices()
        let viewModel = ListViewModel(testeServices: testeServices)
        viewModel.navigationDelegate = self
        myView.viewModel = viewModel
    }
    
}
