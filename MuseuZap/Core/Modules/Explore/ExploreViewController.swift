//
//  ExploreViewController.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 20/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import DatabaseKit

class ExploreViewController: UIViewController, ViewController, NavigationDelegate {
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Fake doing request
        let audioServices = AudioServices(dao: AudioDAO())
        let viewModel = ListViewModel(audioServices: audioServices, audioCategoryServices: AudioCategoryServices(), delegate: myView)
        viewModel.navigationDelegate = self
        myView.viewModel = viewModel
    }

    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           self.setScreenName()
       }
    
    func setup() {
        tabBarItem = UITabBarItem(title: "Explorar", image: UIImage(named: "explore-outline"), selectedImage: UIImage(named: "explore-filled"))
    }
}
