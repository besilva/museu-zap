//
//  AboutView.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 17/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class AboutView: UIView, ViewCodable {
    var submitLabel: UILabel = DynamicLabel()
    var mailLabel: UILabel = DynamicLabel()
    var mailDescription: UILabel = DynamicLabel()
    var contentViewMailLabel: UIView = UIView()
    var contentView: UIView = UIView()
    
    let copyView = UIView()
    let copyLabel = DynamicLabel()
    let clipboardIcon = UIImageView()
    
    let moreInfoTitle = DynamicLabel()
    let moreInfoDescription = DynamicLabel()
    
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
        setupSubmitLabel()
        setupEmailDescription()
        setupMoreInfoTitle()
        setupMoreInfoDescription()
    }
    
    func setupHierarchy() {
//        Inserts copy label and clipboard icon into a content view
        copyView.addSubviews(copyLabel, clipboardIcon)
//        Inserts the copy content view and the email into a content view
        contentViewMailLabel.addSubviews(mailLabel, copyView)
//        Adds email content view into the main view
        contentView.addSubviews(submitLabel, mailDescription, contentViewMailLabel, moreInfoTitle, moreInfoDescription)
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
        
//        Setup Email title label constraints
        submitLabel.setupConstraints { (_) in
            submitLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24).isActive = true
            submitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        }
        
//        Setup Email description constraints
        mailDescription.setupConstraints { (_) in
            mailDescription.topAnchor.constraint(equalTo: submitLabel.bottomAnchor, constant: 8).isActive = true
            mailDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
            mailDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        }

//        Setup constraints for the content view containing email features
        contentViewMailLabel.setupConstraints { (_) in
            contentViewMailLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            contentViewMailLabel.topAnchor.constraint(equalTo: mailDescription.bottomAnchor, constant: 22).isActive = true
            contentViewMailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
            contentViewMailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
            contentViewMailLabel.heightAnchor.constraint(equalToConstant: 56).isActive = true
        }

//        Setup email label constraints
        mailLabel.textAlignment = .left
        mailLabel.setupConstraints { (_) in
            mailLabel.centerYAnchor.constraint(equalTo: contentViewMailLabel.centerYAnchor).isActive = true
            mailLabel.leadingAnchor.constraint(equalTo: contentViewMailLabel.leadingAnchor, constant: 20).isActive = true
            mailLabel.trailingAnchor.constraint(lessThanOrEqualTo: copyView.leadingAnchor, constant: -8).isActive = true
            mailLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        }
        
//        Setup copy content view constraints
        copyView.setupConstraints { (_) in
            copyView.centerYAnchor.constraint(equalTo: contentViewMailLabel.centerYAnchor).isActive = true
            copyView.heightAnchor.constraint(equalToConstant: 24).isActive = true
            copyView.trailingAnchor.constraint(equalTo: contentViewMailLabel.trailingAnchor, constant: -20).isActive = true
        }

//        Setup the copy label constraints
        copyLabel.textAlignment = .right
        copyLabel.setupConstraints { (_) in
            copyLabel.centerYAnchor.constraint(equalTo: copyView.centerYAnchor).isActive = true
            copyLabel.leadingAnchor.constraint(equalTo: copyView.leadingAnchor).isActive = true
            copyLabel.trailingAnchor.constraint(equalTo: clipboardIcon.leadingAnchor, constant: -8).isActive = true
            copyLabel.heightAnchor.constraint(equalTo: copyView.heightAnchor).isActive = true
        }

//        Setup clipboard image constraints
        clipboardIcon.setupConstraints { (_) in
            clipboardIcon.centerYAnchor.constraint(equalTo: copyView.centerYAnchor).isActive = true
            clipboardIcon.trailingAnchor.constraint(equalTo: copyView.trailingAnchor).isActive = true
            clipboardIcon.heightAnchor.constraint(equalTo: copyView.heightAnchor).isActive = true
        }
        
//        Setup more info title constraints
        moreInfoTitle.setupConstraints { (_) in
            moreInfoTitle.topAnchor.constraint(equalTo: contentViewMailLabel.bottomAnchor, constant: 24).isActive = true
            moreInfoTitle.heightAnchor.constraint(equalToConstant: 22).isActive = true
            moreInfoTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
            moreInfoTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        }
        
//        Setup more info description constraints
        moreInfoDescription.setupConstraints { (_) in
            moreInfoDescription.topAnchor.constraint(equalTo: moreInfoTitle.bottomAnchor, constant: 8).isActive = true
            moreInfoDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
            moreInfoDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
            moreInfoDescription.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -24).isActive = true
        }
    }
    
    func render() {
//        Sets label colors and font attributes
        contentView.backgroundColor = UIColor.Default.background
        contentViewMailLabel.backgroundColor = UIColor.Default.lightBackground

        mailLabel.tintColor = UIColor.Default.label
        mailLabel.font = UIFont.Default.regular.withSize(14)
        mailLabel.dynamicFont = mailLabel.font
        
        submitLabel.textColor = UIColor.Default.label
        submitLabel.font = UIFont.Default.semibold.withSize(20)
        submitLabel.dynamicFont = submitLabel.font
        
        mailDescription.textColor = UIColor.Default.lightLabel
        mailDescription.font = UIFont.Default.regular.withSize(14)
        mailDescription.dynamicFont = mailDescription.font
        
        moreInfoTitle.textColor = UIColor.Default.label
        moreInfoTitle.font = UIFont.Default.semibold.withSize(20)
        moreInfoTitle.dynamicFont = moreInfoTitle.font

        moreInfoDescription.textColor = UIColor.Default.lightLabel
        moreInfoDescription.font = UIFont.Default.regular.withSize(14)
        moreInfoDescription.dynamicFont = moreInfoDescription.font

        copyLabel.font = UIFont.Default.regular.withSize(14)
        copyLabel.dynamicFont = copyLabel.font

        clipboardIcon.tintColor = UIColor.Default.power
    }
    
    func updateView() {
        setupContentViewEmailLabel()
        setupEmailLabel()
        setupClipboard()
        setupSubmitLabel()
        setupEmailDescription()
        setupMoreInfoTitle()
        setupMoreInfoDescription()
        render()
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
    
//        Sets clipboard icon image
        clipboardIcon.image = UIImage(named: "doc.on.doc")
        clipboardIcon.contentMode = .scaleAspectFit
        
//        Adds behaviour to copy content to clipboard on tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(addToClipboard))
        copyView.isUserInteractionEnabled = true
        copyView.addGestureRecognizer(tap)
    }

    func setupContentViewEmailLabel() {
        contentViewMailLabel.backgroundColor = UIColor.Default.lightBackground
        contentViewMailLabel.tintColor = UIColor.Default.lightBackground
        contentViewMailLabel.layer.cornerRadius = 4
    }

    func setupSubmitLabel() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.83
        submitLabel.attributedText = NSMutableAttributedString(string: "Submeter áudio",
                                                               attributes: [NSAttributedString.Key.kern: 0.38,
                                                                          NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    func setupEmailDescription() {
        mailDescription.numberOfLines = 0
        mailDescription.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.86
        
        let emailDescription = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nisi elementum nunc, sollicitudin non:"
        mailDescription.attributedText = NSMutableAttributedString(string: emailDescription,
                                                                   attributes: [NSAttributedString.Key.kern: 0.28,
                                                                                NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    func setupMoreInfoTitle() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.86
        moreInfoTitle.attributedText = NSMutableAttributedString(string: "Sobre o Museu do Zap",
                                                                 attributes: [NSAttributedString.Key.kern: 0.28,
                                                                         NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    func setupMoreInfoDescription() {
//        Loads content from view model
        guard let viewModel = viewModel else { return }
        let aboutDescription = viewModel.description

//        Sets text attributes
        moreInfoDescription.numberOfLines = 0
        moreInfoDescription.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.83

        moreInfoDescription.attributedText = NSMutableAttributedString(string: aboutDescription,
                                                                       attributes: [NSAttributedString.Key.kern: 0.38,
                                                                                NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

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
        viewModel.copy()
    }
}
