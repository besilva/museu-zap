//
//  PlaceholderView.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 21/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class PlaceholderView: UIView, ViewCodable {
    var iconImageView: UIImageView = UIImageView()

    var titleSubtitleContentView: UIView = UIView()
    var titleLabel: UILabel = UILabel()
    var subtitleLabel: UILabel = UILabel()

    var actionContentView: UIView = UIView()
    var actionLabel: UILabel = UILabel()
    
    var contentView: UIView = UIView()
    
    var viewModel: PlaceholderViewModelProtocol? {
        didSet {
            setupView()
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
        setupActionContentView()
        setupIconImageView()
        setupTitleLabel()
        setupSubtitleLabel()
        setupActionLabel()
    }

    func setupHierarchy() {
//        Inserts title and subtitle into a content view
        titleSubtitleContentView.addSubviews(titleLabel, subtitleLabel)
//        Inserts label into a content view
        actionContentView.addSubview(actionLabel)
//        Inserts both content views and the icon into the container view
        contentView.addSubviews(iconImageView, titleSubtitleContentView, actionContentView)
        addSubview(contentView)
    }

    func setupConstraints() {

//        Setup content View constraints
        contentView.setupConstraints { (_) in
            contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
        
//        Setup icon constraints
        iconImageView.setupConstraints { (_) in
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32).isActive = true
            iconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            iconImageView.bottomAnchor.constraint(equalTo: titleSubtitleContentView.topAnchor, constant: -24).isActive = true
        }

//        Setup title and subtitle content view constraints
        titleSubtitleContentView.setupConstraints { (_) in
            titleSubtitleContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
            titleSubtitleContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
            titleSubtitleContentView.bottomAnchor.constraint(equalTo: actionContentView.topAnchor, constant: -24).isActive = true
        }
        
//        Setup title label constraints
        titleLabel.textAlignment = .center
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        titleLabel.setupConstraints { (_) in
            titleLabel.topAnchor.constraint(equalTo: titleSubtitleContentView.topAnchor).isActive = true
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -8).isActive = true
            titleLabel.leadingAnchor.constraint(equalTo: titleSubtitleContentView.leadingAnchor).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo: titleSubtitleContentView.trailingAnchor).isActive = true
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 46).isActive = true
        }
        
//        Setup subtitle label constraints
        subtitleLabel.textAlignment = .center
        subtitleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        subtitleLabel.setupConstraints { (_) in
            subtitleLabel.bottomAnchor.constraint(equalTo: titleSubtitleContentView.bottomAnchor).isActive = true
            subtitleLabel.leadingAnchor.constraint(equalTo: titleSubtitleContentView.leadingAnchor).isActive = true
            subtitleLabel.trailingAnchor.constraint(equalTo: titleSubtitleContentView.trailingAnchor).isActive = true
            subtitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 36).isActive = true
        }
        
//        Setup action content view constraints
        actionContentView.setupConstraints { (_) in
            actionContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 35).isActive = true
            actionContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35).isActive = true
            actionContentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 48).isActive = true
        }
        
//        Setup action label constraints
        actionLabel.textAlignment = .center
        actionLabel.setupConstraints { (_) in
            actionLabel.topAnchor.constraint(equalTo: actionContentView.topAnchor, constant: 10).isActive = true
            actionLabel.bottomAnchor.constraint(equalTo: actionContentView.bottomAnchor, constant: -10).isActive = true
            actionLabel.leadingAnchor.constraint(equalTo: actionContentView.leadingAnchor, constant: 16).isActive = true
            actionLabel.trailingAnchor.constraint(equalTo: actionContentView.trailingAnchor, constant: -16).isActive = true
            actionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true
        }
    }
    
    func render() {
//        Sets background color for each component
        contentView.backgroundColor = UIColor.Default.background
        titleSubtitleContentView.backgroundColor = UIColor.Default.background
        actionContentView.backgroundColor = UIColor.Default.power

//        Sets font attributes for title label
        titleLabel.textColor = UIColor.Default.label
        titleLabel.font = UIFont.Default.semibold.withSize(17)
//        titleLabel.dynamicFont = titleLabel.font

//        Sets font attributes for subtitle label
        subtitleLabel.textColor = UIColor.Default.lightLabel
        subtitleLabel.font = UIFont.Default.regular.withSize(14)
//        subtitleLabel.dynamicFont = subtitleLabel.font

//        Sets font attributes for action label
        actionLabel.textColor = UIColor.Default.background
        actionLabel.font = UIFont.Default.semibold.withSize(17)
//        actionLabel.dynamicFont = subtitleLabel.font
        
        iconImageView.tintColor = UIColor.Default.lightLabel
        return
    }
}

// MARK: Setup subviews
extension PlaceholderView {
    func setupIconImageView() {
//        Sets icon image
        iconImageView.image = UIImage(named: "folder.fill.badge.plus")
        iconImageView.contentMode = .scaleAspectFit
    }

    func setupTitleLabel() {
        guard let viewModel = viewModel else {
            return
        }

        let title = viewModel.title
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .center
        titleLabel.text = title
        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 0.9
        paragraphStyle.lineSpacing = 2.3
        // Line height: 23 pt
        titleLabel.textAlignment = .center
        titleLabel.attributedText = NSMutableAttributedString(string: title,
                                                              attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    func setupSubtitleLabel() {
        guard let viewModel = viewModel else {
           return
        }
        let subtitle = viewModel.subtitle
        subtitleLabel.numberOfLines = 0
        subtitleLabel.lineBreakMode = .byWordWrapping
        subtitleLabel.textAlignment = .center
        subtitleLabel.text = subtitle
        let paragraphStyle = NSMutableParagraphStyle()

//        paragraphStyle.lineHeightMultiple = 0.86
        paragraphStyle.lineSpacing = 1.8
        subtitleLabel.attributedText = NSMutableAttributedString(string: subtitle,
                                                                 attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    func setupActionContentView() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(performAction))
        actionContentView.addGestureRecognizer(tap)
        actionContentView.isUserInteractionEnabled = true
        actionContentView.layer.cornerRadius = 10
    }

    func setupActionLabel() {
        guard let viewModel = viewModel else {
            return
        }
        let actionText = viewModel.actionMessage
        actionLabel.textAlignment = .center
        actionLabel.text = actionText
    }
    
    @objc func performAction() throws {
        if let viewModel = self.viewModel {
            viewModel.performAction()
        } else {
            throw PlaceholderError.nilValue
        }
    }
}

extension PlaceholderView: PlaceholderViewModelDelegate {
    func hide() {
        self.isHidden = true
    }
    
    func unhide() {
        self.isHidden = false
    }
}
