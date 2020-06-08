//
//  DetailViewController.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 15/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, ViewController, NavigationDelegate {
    var screenName: String { return "Contato" }
    weak var delegate: NavigationDelegate?
    var viewModel: AboutViewModel?
    // swiftlint:disable force_cast
    private var myView: AboutView {
        return view as! AboutView
    }
    // swiftlint:enable force_cast
    
    // Sets default view
    override func loadView() {
        let myView = AboutView()
        view = myView
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets view content
        self.title = "Info"
        // swiftlint:disable line_length
        let aboutDescription = "Blin surgiu com a intenção de organizar e compartilhar áudios que circulam de forma desordenada pela internet.\n\nNão nos responsabilizamos pelo conteúdo dos áudios aqui compartilhados. Se encontrar algo que considere impróprio, ofensivo e/ou abusivo, fale conosco."
        // swiftlint:enable line_length
        
        // Initializes view model and binds to view
        let viewModel = AboutViewModel(email: "sample@mail.com", description: aboutDescription)
        setNavBarItem()
        myView.viewModel = viewModel
        viewModel.navigationDelegate = self
    }
    
    // Handles navigation actions
    func handleNavigation(action: Action) {
        switch action {
        // Handles alert when copying an email
        case .presentAlert( _, let message, let timeout, let preferredStyle):
            // Shows and dismisses alert
            let alert = UIAlertController(title: nil, message: message, preferredStyle: preferredStyle)
            
            alert.show(self, sender: nil)
            let when = DispatchTime.now() + (timeout ?? 2)
//            Dismiss after delay
            DispatchQueue.main.asyncAfter(deadline: when) {
                alert.dismiss(animated: true, completion: nil)
            }
            present(alert, animated: true)
            
        default:
            delegate?.handleNavigation(action: action)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setScreenName()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.delegate?.handleNavigation(action: .back)
    }
    
    func setup() {
          tabBarItem = UITabBarItem(title: "Sobre", image: UIImage(named: "about-outline"), selectedImage: UIImage(named: "about-filled"))
    }
    
    func setNavBarItem() {
        let barItem = UIBarButtonItem(title: "Cancelar",
                                      style: .plain,
                                      target: self,
                                      action: #selector(backTapped))
        barItem.tintColor = UIColor.Default.power
        navigationItem.leftBarButtonItem = barItem
    }
    
    @objc func backTapped() {
        self.handleNavigation(action: .back)
    }
}
