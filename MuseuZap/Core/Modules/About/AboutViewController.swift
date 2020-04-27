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
    // swiftlint:disable force_cast
    private var myView: AboutView {
        return view as! AboutView
    }
    // swiftlint:enable force_cast
    
    override func loadView() {
        let myView = AboutView()
        view = myView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Info"

        let aboutDescription1 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nisi elementum nunc, sollicitudin non pellentesque. In egestas adipiscing vestibulum varius "
        let aboutDescription2 = "urna sed ornare consectetur. Convallis in volutpat fermentum ipsum in condimentum ut. Odio ornare id ornare augue. Aliquam sit cras arcu amet erat maecenas mi, amet."
        
        let viewModel = AboutViewModel(email: "sample@mail.com", description: aboutDescription1 + aboutDescription2)
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
