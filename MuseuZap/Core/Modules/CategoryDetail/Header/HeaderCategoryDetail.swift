//
//  HeaderCategoryDetail.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 05/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class HeaderCategoryDetail: UIView, ViewCodable {

    var titleLabel: UILabel
    var audioCountLabel: UILabel
    var lineView: UIView
    var viewModel: HeaderCategoryDetailViewModel? {
        didSet {
             configure()
        }
    }
    
    override init(frame: CGRect) {
        titleLabel = UILabel()
        audioCountLabel = UILabel()
        lineView = UIView()
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HeaderCategoryDetail {
    
    func configure() {
        titleLabel.text = viewModel?.title
        audioCountLabel.text = viewModel?.audioCount
    }
    
    func setupHierarchy() {
        addSubviews(titleLabel, audioCountLabel, lineView)
    }
    
    func setupConstraints() {

        titleLabel.setupConstraints { (view) in
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: 32).isActive = true
            view.heightAnchor.constraint(equalToConstant: 20).isActive = true
            view.bottomAnchor.constraint(equalTo: self.audioCountLabel.topAnchor, constant: -8).isActive = true
        }
        audioCountLabel.setupConstraints { (view) in
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
            view.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -24).isActive = true
            view.heightAnchor.constraint(equalToConstant: 12).isActive = true
        }
        
        lineView.setupConstraints { (view) in
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        }
    }
    
    func render() {
        self.backgroundColor = UIColor.Default.background
        let titleFont = UIFont.Default.semibold
        titleLabel.font = titleFont.withSize(20)
        let audioCountFont = UIFont.Default.regular
        audioCountLabel.font = audioCountFont.withSize(12)
        audioCountLabel.textColor = UIColor.Default.lightLabel
        lineView.backgroundColor = .lightGray
    }
}
