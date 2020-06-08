//
//  SectionsHeaderView.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 03/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import DatabaseKit

struct SectionsHeaderViewModel {
    let category: AudioCategory?
    var action: (AudioCategory) -> Void
    var title: String { return category?.categoryName ?? ""}
}

/// Creates the view used for tableView Sections
class SectionsHeaderView: UIView, ViewCodable {

    // MARK: - Properties
    internal var viewModel: SectionsHeaderViewModel? {
        didSet {
            renderLabels()
        }
    }

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
    
    @objc func seeAll() {
        guard let category  = viewModel?.category else { return }
        viewModel?.action(category)
    }

    // MARK: - Set Up

    func configure() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(seeAll))
        seeAllButton.addGestureRecognizer(tap)
    }

    func setupHierarchy() {
        contentView.addSubviews(sectionLabel, seeAllButton)

        self.addSubviews(contentView)
    }

    func setupConstraints() {
        setContentViewConstraints()
        setSectionLabelConstraints()
        setSeeAllButtonConstraints()
    }

    func render() {
        renderLabels()
    }

    // MARK: - Set Up Helpers

    func renderLabels() {
        sectionLabel.text = viewModel?.title
        sectionLabel.textColor = UIColor.Default.label
        sectionLabel.font = UIFont.Default.semibold.withSize(20)

        seeAllButton.setTitle("Ver todos", for: .normal)
        seeAllButton.setTitleColor(UIColor.Default.power, for: .normal)
        seeAllButton.titleLabel?.font = UIFont.Default.regular.withSize(15)
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
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
            view.heightAnchor.constraint(equalToConstant: 44).isActive = true
            view.trailingAnchor.constraint(lessThanOrEqualTo: seeAllButton.leadingAnchor, constant: -8).isActive = true
        }
    }

    func setSeeAllButtonConstraints() {
        seeAllButton.sizeToFit()
        seeAllButton.setContentCompressionResistancePriority(.required, for: .vertical)
        seeAllButton.setupConstraints { (view) in
            view.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
            view.heightAnchor.constraint(equalToConstant: 44).isActive = true
            view.widthAnchor.constraint(equalToConstant: 80).isActive = true
        }
        seeAllButton.titleLabel?.lastBaselineAnchor.constraint(equalTo: sectionLabel.lastBaselineAnchor).isActive = true
    }
}
