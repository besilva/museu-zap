//
//  MyAudiosViewController.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 01/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import DatabaseKit

class MyAudiosViewController: ListViewController {
    override var screenName: String { return "Meus Áudios"}
    
    override func handleNavigation(action: Action) {
        delegate?.handleNavigation(action: action)
    }

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

    private var myView: MyAudiosView {
        // swiftlint:disable force_cast
        return view as! MyAudiosView
    }
 
    override func loadView() {
        let myView = MyAudiosView()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Fake doing request
        self.title = "Meus Áudios"
        let categoryServices = AudioCategoryServices()
        let audioServices = AudioServices(dao: AudioDAO())
        let viewModel = MyAudiosViewModel(audioServices: audioServices, audioCategoryServices: categoryServices, delegate: myView)
        viewModel.navigationDelegate = self
        myView.viewModel = viewModel
    }

    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           self.setScreenName()
       }
    
    override func setup() {
        tabBarItem = UITabBarItem(title: "Meus áudios", image: UIImage(named: "folder"), selectedImage: UIImage(named: "folder.fill"))
    }
    
    override func retrieveAllAudios() {
        let audioServices = AudioServices()
        let audioCategoryServices = AudioCategoryServices()
        
        audioServices.getAllAudiosWith(isPrivate: true) { (error, audioArray) in
            if let audios = audioArray {
                let viewModel = MyAudiosViewModel(audioServices: audioServices, audioCategoryServices: audioCategoryServices, delegate: self.myView)
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
