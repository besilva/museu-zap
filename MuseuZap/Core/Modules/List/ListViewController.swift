//
//  ListViewController.swift
//  MVVM-POC
//
//  Created by Bernardo Silva on 01/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, ViewController, Delegatable {
    weak var delegate: Delegatable?
    private var myView: ListView {
        return view as! ListView
    }
 
    override func loadView() {
        let myView = ListView()
        view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Fake doing request
        let array = [("titulo", "subtitulo")]
        let viewModel = ListViewModel(array: array)
        viewModel.navigationDelegate = self
        myView.viewModel = viewModel
    }
    
}
