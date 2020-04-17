//
//  DetailViewController.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 15/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, ViewController, NavigationDelegate {
    weak var delegate: NavigationDelegate?
    var viewModel: AboutViewModel?
    
    private var myView: AboutView {
        return view as! AboutView
    }
    
    override func loadView() {
        let myView = AboutView()
        view = myView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = AboutViewModel(email: "sample@mail.com", description: "sample description")
        myView.viewModel = viewModel
        viewModel.navigationDelegate = self
    }
    
    
}
