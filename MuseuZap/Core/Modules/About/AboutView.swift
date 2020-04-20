//
//  AboutView.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 17/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class AboutView: UIView, ViewCodable {
    var mailLabel: UILabel = UILabel()
    var contentView: UIView = UIView()

    var viewModel: AboutViewModelProtocol? {
        didSet {
            updateView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        setupEmailLabel()
    }
    
    func setupHierarchy() {
        contentView.addSubview(mailLabel)
        addSubview(contentView)
    }
    
    func setupConstraints() {
        mailLabel.textAlignment = .center
        mailLabel.setupConstraints { (view) in
            mailLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            mailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            mailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            mailLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            mailLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
//            mailLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        }
        
        contentView.setupConstraints { (view) in
           contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
           contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
           contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
           contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
       }
    }
    
    func render() {
        if #available(iOS 13, *) {
            contentView.backgroundColor = .systemBackground
            mailLabel.tintColor = .label
        }
        return
    }
    
    func updateView() {
        setupEmailLabel()
    }
    
    func setupEmailLabel() {
        guard let viewModel = viewModel else { return }
        mailLabel.text = viewModel.email
        let underlineAttriString = NSAttributedString(string: viewModel.email,
                                                  attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        mailLabel.attributedText = underlineAttriString
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        mailLabel.addGestureRecognizer(tap)
        mailLabel.isUserInteractionEnabled = true
        
    }
    
    @objc func handleTap() {
        self.viewModel?.delegate?.handleTap()
    }
}
