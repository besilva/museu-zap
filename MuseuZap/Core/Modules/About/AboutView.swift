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
    
    let copyView = UIView()
    let copyLabel = UILabel()
    let clipboardIcon = UIImageView()
    
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
        setupContentViewEmailLabel()
        setupEmailLabel()
        setupClipboard()
//        setupEmailTitle()
//        setupEmailDescription()
    }
    
    func setupHierarchy() {
//        Inserts copy label and clipboard icon into a content view
        copyView.addSubviews(copyLabel, clipboardIcon)
//        Inserts the copy content view and the email into a content view
        contentViewMailLabel.addSubviews(mailLabel, copyView)
//        Adds email content view into the main view
        contentView.addSubviews(contentViewMailLabel)
        addSubview(contentView)
    }
    
    func setupConstraints() {
//        Setup content View constraints
        let margins = self.layoutMarginsGuide
        contentView.setupConstraints { (_) in
            contentView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
        
//        Setup constraints for the content view containing email features
        contentViewMailLabel.setupConstraints { (_) in
            contentViewMailLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            contentViewMailLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 56).isActive = true
            contentViewMailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
            contentViewMailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
            contentViewMailLabel.heightAnchor.constraint(equalToConstant: 56).isActive = true
        }

//        Setup email label constraints
        mailLabel.textAlignment = .left
        mailLabel.setupConstraints { (_) in
            mailLabel.centerYAnchor.constraint(equalTo: contentViewMailLabel.centerYAnchor).isActive = true
            mailLabel.leadingAnchor.constraint(equalTo: contentViewMailLabel.leadingAnchor, constant: 12).isActive = true
            mailLabel.trailingAnchor.constraint(lessThanOrEqualTo: copyView.leadingAnchor, constant: -8).isActive = true
            mailLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        }
        
//        Setup copy content view constraints
        copyView.setupConstraints { (_) in
            copyView.centerYAnchor.constraint(equalTo: contentViewMailLabel.centerYAnchor).isActive = true
            copyView.heightAnchor.constraint(equalToConstant: 24).isActive = true
            copyView.trailingAnchor.constraint(equalTo: contentViewMailLabel.trailingAnchor, constant: -12).isActive = true
        }

//        Setup the copy label constraints
        copyLabel.textAlignment = .right
        copyLabel.setupConstraints { (_) in
            copyLabel.centerYAnchor.constraint(equalTo: copyView.centerYAnchor).isActive = true
            copyLabel.leadingAnchor.constraint(equalTo: copyView.leadingAnchor, constant: 8).isActive = true
            copyLabel.trailingAnchor.constraint(equalTo: clipboardIcon.leadingAnchor, constant: -8).isActive = true
            copyLabel.heightAnchor.constraint(equalTo: copyView.heightAnchor).isActive = true
        }

//        Setup clipboard image constraints
        clipboardIcon.setupConstraints { (_) in
            clipboardIcon.centerYAnchor.constraint(equalTo: copyView.centerYAnchor).isActive = true
            clipboardIcon.trailingAnchor.constraint(equalTo: copyView.trailingAnchor, constant: -12).isActive = true
            clipboardIcon.heightAnchor.constraint(equalTo: copyView.heightAnchor).isActive = true
        }
    }
    
    func render() {
//        Sets label colors
        contentView.backgroundColor = UIColor.Default.background
        contentViewMailLabel.backgroundColor = UIColor.Default.lightBackground
        mailLabel.tintColor = UIColor.Default.label
    }
    
    func updateView() {
//        setupEmailTitle()
//        setupEmailDescription()
        setupContentViewEmailLabel()
        setupEmailLabel()
        setupClipboard()
    }
    
    func setupEmailLabel() {
//        Loads content from view model
        guard let viewModel = viewModel else { return }
        mailLabel.text = viewModel.email
        
//        Adds feature to send email on tap
        let underlineAttriString = NSAttributedString(string: viewModel.email,
                                                  attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        mailLabel.attributedText = underlineAttriString
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        mailLabel.addGestureRecognizer(tap)
        mailLabel.isUserInteractionEnabled = true
    }

    func setupClipboard() {
//        Sets copy label attributes
        copyLabel.text = "Copiar"
        copyLabel.textAlignment = .right
        copyLabel.font = copyLabel.font.withSize(14)
    
//        Sets clipboard icon image
        clipboardIcon.image = UIImage(named: "doc.on.doc")
        clipboardIcon.contentMode = .scaleAspectFit
        
//        Adds behaviour to copy content to clipboard on tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(addToClipboard))
        copyView.isUserInteractionEnabled = true
        copyView.addGestureRecognizer(tap)
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
//        Sends email to viewModel email, throws error if viewModel is nil
        if let viewModel = self.viewModel {
            try viewModel.sendEmail()
        } else {
            throw AboutError.nilValue
        }
    }

    @objc func addToClipboard() throws {
        guard let viewModel = viewModel else {
            throw AboutError.nilValue
        }
        UIPasteboard.general.string = viewModel.email
        self.viewModel?.copy()
    }
}
