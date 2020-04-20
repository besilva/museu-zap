//
//  ListViewController.swift
//  MVVM-POC
//
//  Created by Bernardo Silva on 01/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, ViewController, NavigationDelegate {
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
        // Fake doing request
        let testeServices = TesteServices()
        let viewModel = ListViewModel(testeServices: testeServices)
        viewModel.navigationDelegate = self
        myView.viewModel = viewModel
    }
    
}
