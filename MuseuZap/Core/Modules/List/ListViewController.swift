//
//  ListViewController.swift
//  MVVM-POC
//
//  Created by Bernardo Silva on 01/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class ListViewController: UIViewController{
   
    private var myView: ListView {
        return view as! ListView
    }
 
    override func loadView() {
        let myView = ListView()
        view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fake doing request
        let array = [("titulo", "subtitulo")]
        let viewModel = ListViewModel(array: array)
        myView.viewModel = viewModel
    }
    
}

