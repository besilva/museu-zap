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

    // TODO: alterar espaçamento da fonte?

    // MARK: - Properties

    public var seeAllButton: UIButton
    public var sectionLabel: UILabel
    /// Helps autoLayout to calculate height
    private var contentView: UIView

    // MARK: - Init

    override init(frame: CGRect) {
        contentView = UIView()
        seeAllButton = UIButton()
        sectionLabel = UILabel()

        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Set Up

    func configure() { }

    func setupHierarchy() {
        contentView.addSubviews(sectionLabel, seeAllButton)

        self.addSubviews(contentView)
    }

    func setupConstraints() {
        // SectionsHeaderView width should be equal to screenWidth - 2x(tableViewSpacing), leading and trailing
        self.translatesAutoresizingMaskIntoConstraints = false
        let width = UIScreen.main.bounds.width - (2 * Constants.tableViewSpacing)
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        // UIButton at this label has height equal to 33
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: 33).isActive = true

        setContentViewConstraints()
        setSectionLabelConstraints()
        setSeeAllButtonConstraints()
    }

    func render() {
        renderLabels()
    }

    // MARK: - Set Up Helpers

    func renderLabels() {
        sectionLabel.text = "Default"
        sectionLabel.textColor = UIColor.Default.label
        sectionLabel.font = UIFont.Default.semibold.withSize(20)

        seeAllButton.setTitle("Ver todos", for: .normal)
        seeAllButton.setTitleColor(UIColor.Default.power, for: .normal)
        seeAllButton.titleLabel?.font = UIFont.Default.regular.withSize(15)
//      seeAllButton.dynamicFont = seeAllButton.titleLabel?.font
        // TODO: ver a extensão dynamic também para botões ou só colocar label mesmo
    }

    // MARK: - Constraints

    func setContentViewConstraints() {
        contentView.setupConstraints { (view) in
            // Pin contentView to be the size of the view itself
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }
    }

    func setSectionLabelConstraints() {
        sectionLabel.sizeToFit()
        sectionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        sectionLabel.setupConstraints { (view) in
            view.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        }
    }

    func setSeeAllButtonConstraints() {
        seeAllButton.sizeToFit()
        seeAllButton.setContentCompressionResistancePriority(.required, for: .vertical)
        seeAllButton.setupConstraints { (view) in
            view.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
        seeAllButton.titleLabel?.lastBaselineAnchor.constraint(equalTo: sectionLabel.lastBaselineAnchor).isActive = true
    }
}
