//
//  ExploreViewController.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 20/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import DatabaseKit

class ExploreViewController: ListViewController {

    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var myView: ExploreView {
        // swiftlint:disable force_cast
        return view as! ExploreView
    }
 
    override func loadView() {
        let myView = ExploreView()
//        Sets the action handler for the List View
        myView.audioHandler = { (action) in
//            The list view performs the action using the list view controller
//            Navigation delegate
            self.delegate?.handleNavigation(action: action)
        }
        view = myView
        
        // This was set to true so resultController could work properly
        extendedLayoutIncludesOpaqueBars = true
        self.title = "Descobrir"
    }
    
    override func retrieveAllAudios() {
        let audioServices = AudioServices()
        let audioCategoryServices = AudioCategoryServices()
        
        audioServices.getAllAudiosWith(isPrivate: false) { (error, audioArray) in
            if let audios = audioArray {
                let viewModel = ExploreViewModel(audioServices: audioServices, audioCategoryServices: audioCategoryServices, delegate: self.myView)
                viewModel.navigationDelegate = self
                viewModel.audios = audios
                self.myView.viewModel = viewModel
            } else {
                // Display here some frendiler message based on Error Type (database error or not)
                print(error ?? "Some default error value")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightButton = UIBarButtonItem(title: "About", style: .plain, target: self, action: #selector(aboutTapped))
        rightButton.image = UIImage(named: "envelope")
        rightButton.tintColor = UIColor.Default.power
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func aboutTapped() {
        self.delegate?.handleNavigation(action: .about)
    }
}
