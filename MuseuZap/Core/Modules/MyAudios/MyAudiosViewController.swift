//
//  MyAudiosViewController.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 01/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import DatabaseKit

class MyAudiosViewController: UIViewController, ViewController, NavigationDelegate {
    var screenName: String { return "Meus Áudios"}
    
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

    private var myView: MyAudiosView {
        // swiftlint:disable force_cast
        return view as! MyAudiosView
    }
 
    override func loadView() {
        let myView = MyAudiosView()
        view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Fake doing request
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
    
    func setup() {
        tabBarItem = UITabBarItem(title: "Meus áudios", image: UIImage(named: "folder"), selectedImage: UIImage(named: "folder.fill"))
    }
}
