//
//  DetailViewController.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 15/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    var viewModel: AboutViewModel?
    var mailLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
    }
    
    func setupLabels() {
        self.setupMailLabel()
    }
    
    func setupMailLabel() {
        guard let viewModel = viewModel else { return }
        mailLabel.text = viewModel.email
        let underlineAttriString = NSAttributedString(string: viewModel.email,
                                                  attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        mailLabel.attributedText = underlineAttriString
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        mailLabel.addGestureRecognizer(tap)
        mailLabel.isUserInteractionEnabled = true
        
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if let url = URL(string: "mailto:\(mailLabel.text ?? "foo@bar.com")") {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
    }
}
