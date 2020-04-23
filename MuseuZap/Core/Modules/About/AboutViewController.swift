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
        let viewModel = AboutViewModel(email: "sample@mail.com", description: "sample description"  )
        myView.viewModel = viewModel
        viewModel.navigationDelegate = self
    }
    
    func handleNavigation(action: Action) {
        switch action {
        case .presentAlert( _, let message, let timeout, let preferredStyle):
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
}
