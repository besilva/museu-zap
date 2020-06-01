//
//  ListViewController.swift
//  MVVM-POC
//
//  Created by Bernardo Silva on 01/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import CoreData
import DatabaseKit

class ListViewController: UIViewController, ViewController, NavigationDelegate {
    var screenName: String { return "Início Destaques"}
    
    func handleNavigation(action: Action) {
        return
    }
    
    weak var delegate: NavigationDelegate?
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    private var myView: ListView {
        // swiftlint:disable force_cast
        return view as! ListView
    }
 
    override func loadView() {
        let myView = ListView()
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.retrieveAllAudios()
        // Somehow topBarHeight has to be populated here, because outside here reference to navigationBar is nil
        // Set the navBarHeight to calculate topBarHeight for refreshController
        myView.navBarHeight = self.navBarHeight
        // TODO: olhar onde que a search pode ser setada. Precisa da viewmodel para setar ela, e a viewModel é setada no retrieveAllAudios
        navigationItem.searchController = myView.searchController
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setScreenName()
    }
    
    func setup() {
        tabBarItem = UITabBarItem(title: "Explorar", image: UIImage(named: "explore-outline"), selectedImage: UIImage(named: "explore-filled"))
    }
    
    // MARK: - Core Data
    
    // Set ViewModel
    func retrieveAllAudios() {
        let audServices = AudioServices()
        let audCatServices = AudioCategoryServices()
        
        audServices.getAllAudios { (error, audioArray) in
            if let audios = audioArray {
                let viewModel = ListViewModel(audioServices: audServices, audioCategoryServices: audCatServices, delegate: self.myView)
                viewModel.navigationDelegate = self
                viewModel.audios = audios
                self.myView.viewModel = viewModel
            } else {
                // Display here some frendiler message based on Error Type (database error or not)
                print(error ?? "Some default error value")
            }
        }
    }
}
