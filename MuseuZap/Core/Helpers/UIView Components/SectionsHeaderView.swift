//
//  SectionsHeaderView.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 03/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

/// Creates the view used for tableView Sections
class SectionsHeaderView: UIView, ViewCodable {

    // MARK: - Properties

    private var stack: UIStackView
    public var seeAllButton: UIButton
    public var sectionLabel: UILabel

    // MARK: - Init

    override init(frame: CGRect) {
        stack = UIStackView()
        seeAllButton = UIButton()
        sectionLabel = UILabel()

        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Set Up

    func configure() {
    }

    func setupHierarchy() {
        stack.addSubviews(sectionLabel, seeAllButton)
        self.addSubviews(stack)
    }

    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        setUpStackConstraints()
    }

    func render() {
        seeAllButton.titleLabel?.text = "Default"
        seeAllButton.titleLabel?.textColor = UIColor.Default.power
        seeAllButton.titleLabel?.font = UIFont.Default.regular.withSize(15)
//        seeAllButton.dynamicFont = seeAllButton.titleLabel?.font
        // TODO: ver a extensão dynamic também para botões ou só colocar label mesmo
    }

    // MARK: - Set Up Helpers

    /// Creates minimum hitArea constraints as fixed constrains
    func setUpStackConstraints() {
        stack.setupConstraints { (view) in

            // Height
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
            // Pin stack to be the size of the view itself
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }
    }

}
