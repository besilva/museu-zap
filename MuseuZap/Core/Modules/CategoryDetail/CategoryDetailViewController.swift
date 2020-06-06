//
//  CategoryDetailViewController.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 05/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation
import DatabaseKit

class CategoryDetailViewController: ListViewController {
    override var screenName: String { "Categoria"}
    let category: AudioCategory

    private var myView: ListView {
        // swiftlint:disable force_cast
        return view as! CategoryDetailView
    }
    
    init(category: AudioCategory) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
        self.title = category.categoryName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let myView = CategoryDetailView(category: self.category)
        //        Sets the action handler for the List View
        myView.audioHandler = { (action) in
            //            The list view performs the action using the list view controller
            //            Navigation delegate
            self.delegate?.handleNavigation(action: action)
        }
        view = myView
        
        // This was set to true so resultController could work properly
        extendedLayoutIncludesOpaqueBars = true
    }
    
    override func retrieveAllAudios() {
        let audioServices = AudioServices()
        let audioCategoryServices = AudioCategoryServices()
        if let audios = category.audios {
           let viewModel = ListViewModel(audioServices: audioServices, audioCategoryServices: audioCategoryServices, delegate: self.myView)
           viewModel.navigationDelegate = self
           viewModel.audios = Array(audios)
           self.myView.viewModel = viewModel
       } else {
           // Display here some frendiler message based on Error Type (database error or not)
           print("Some default error value")
       }
       
    }
    
}
