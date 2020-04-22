//
//  AboutView.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 17/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class AboutView: UIView, ViewCodable {
    var mailTitle: UILabel = UILabel()
    var mailLabel: UILabel = UILabel()
    var mailDescription: UILabel = UILabel()
    var contentViewMailLabel: UIView = UIView()
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
//        setupEmailTitle()
//        setupEmailDescription()
    }
    
    func setupHierarchy() {
        contentViewMailLabel.addSubview(mailLabel)
        contentView.addSubviews(contentViewMailLabel)
        addSubview(contentView)
    }
    
    func setupConstraints() {
        let margins = self.layoutMarginsGuide
        contentView.setupConstraints { (_) in
            contentView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
        
//        mailTitle.setupConstraints { (_) in
//            mailTitle.widthAnchor.constraint(equalToConstant: 127).isActive = true
//            mailTitle.heightAnchor.constraint(equalToConstant: 22).isActive = true
//            mailTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -123.5).isActive = true
//            mailTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -325).isActive = true
//        }
//
//        mailDescription.setupConstraints { (_) in
//            mailDescription.heightAnchor.constraint(equalToConstant: 36).isActive = true
//            mailDescription.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -288).isActive = true
//        }
        
        contentViewMailLabel.setupConstraints { (_) in
            contentViewMailLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            contentViewMailLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 56).isActive = true
            contentViewMailLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
            contentViewMailLabel.heightAnchor.constraint(equalToConstant: 56).isActive = true
        }

        mailLabel.textAlignment = .left
        mailLabel.setupConstraints { (_) in
            mailLabel.centerYAnchor.constraint(equalTo: contentViewMailLabel.centerYAnchor).isActive = true
            mailLabel.leadingAnchor.constraint(equalTo: contentViewMailLabel.leadingAnchor, constant: 12).isActive = true
//            mailLabel.trailingAnchor.constraint(equalTo: contentMailLabelView.trailingAnchor).isActive = true
            mailLabel.centerXAnchor.constraint(equalTo: contentViewMailLabel.centerXAnchor).isActive = true
            mailLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        }
    }
    
    func render() {
        contentView.backgroundColor = UIColor(named: "background")
        contentViewMailLabel.backgroundColor = UIColor(named: "lightBackground")
        mailLabel.tintColor = UIColor(named: "label")
    }
    
    func updateView() {
//        setupEmailTitle()
//        setupEmailDescription()
        setupContentViewEmailLabel()
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
    
    func setupContentViewEmailLabel() {
        contentViewMailLabel.layer.cornerRadius = 4
    }
//    func setupEmailTitle() {
//        mailTitle.frame = CGRect(x: 0, y: 0, width: 127, height: 22)
//        mailTitle.backgroundColor = .white
//        mailTitle.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
//        mailTitle.font = UIFont(name: "SFProText-Semibold", size: 17)
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1.08
//        mailTitle.attributedText = NSMutableAttributedString(string: "Submeter áudio", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
//    }
//
//    func setupEmailDescription() {
//        mailDescription.frame = CGRect(x: 0, y: 0, width: 374, height: 36)
//        mailDescription.backgroundColor = .white
//        mailDescription.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
//        mailDescription.font = UIFont(name: "SFProText-Regular", size: 15)
//        mailDescription.numberOfLines = 0
//        mailDescription.lineBreakMode = .byWordWrapping
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1.01
//
//        mailDescription.attributedText = NSMutableAttributedString(string: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nisi elementum nunc, sollicitudin non:", attributes: [NSAttributedString.Key.kern: -0.24, NSAttributedString.Key.paragraphStyle: paragraphStyle])
//    }

    @objc func handleTap() throws {
        if let viewModel = self.viewModel {
            try viewModel.sendEmail()
        } else {
            throw AboutError.nilValue
        }
    }
}
