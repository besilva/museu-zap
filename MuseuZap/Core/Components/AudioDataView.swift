//
//  AudioDataView.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 04/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

/// Creates the AudioDataView used to display Audio Name and Audio Duration
class AudioDataView: UIView, ViewCodable {

    // MARK: - Properties

    public var titleLabel: UILabel
    public var durationLabel: UILabel
    /// Helps autoLayout to calculate height
    private var contentView: UIView

    // MARK: - Init

    override init(frame: CGRect) {
        contentView = UIView()
        titleLabel = UILabel()
        durationLabel = UILabel()

        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Set Up

    func configure() {
        setupTitleLabel()
        setupDurationLabel()
    }

    func setupHierarchy() {
        contentView.addSubviews(titleLabel, durationLabel)

        self.addSubviews(contentView)
    }

    func setupConstraints() {
        // AudioDataView width should be greater than 00:00 (duration label), 40
        // Height should be be greater than minum duration + one line title label, 45
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: 45).isActive = true

        setContentViewConstraints()
        setTitleLabelConstraints()
        setDurationLabelConstraints()
    }

    func render() {
        renderLabels()
    }

    // MARK: - Set Up Helpers

    func setupTitleLabel() {
        titleLabel.numberOfLines = 0
        let paragraphStyle = NSMutableParagraphStyle()

        // Sets text style attributes, with default value
        paragraphStyle.lineHeightMultiple = 0.9
        let attributedText = NSMutableAttributedString(string: "A",
                                                       attributes: [NSAttributedString.Key.kern: 0.34,
                                                                    NSAttributedString.Key.paragraphStyle: paragraphStyle])
        titleLabel.attributedText = attributedText
        titleLabel.textAlignment = .left
    }

    func setupDurationLabel() {
        // Sets text style attributes, with default value
        let attributedText = NSMutableAttributedString(string: "00:00",
                                                       attributes: [NSAttributedString.Key.kern: 0.07])
        durationLabel.attributedText = attributedText
        durationLabel.textAlignment = .left
    }

    func renderLabels() {
        // Sets text attributes for title label
        titleLabel.textColor = UIColor.Default.label
        titleLabel.font = UIFont.Default.semibold
        titleLabel.dynamicFont = titleLabel.font

        // Sets duration label visual attributes
        durationLabel.textColor = UIColor.Default.lightLabel
        let durationlabelFont = UIFont.Default.regular
        durationLabel.font = durationlabelFont.withSize(12)
        durationLabel.dynamicFont = durationlabelFont
    }

    // MARK: - Constraints

    func setContentViewConstraints() {
        contentView.setContentCompressionResistancePriority(.required, for: .vertical)
        contentView.setupConstraints { (view) in
            // Pin contentView to be the size of the view itself
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }
    }

    func setTitleLabelConstraints() {
        titleLabel.sizeToFit()
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.setupConstraints { (_) in
            titleLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        }
    }

    func setDurationLabelConstraints() {
        durationLabel.setupConstraints { (_) in
            let topConstraint = NSLayoutConstraint(item: durationLabel,
                                                   attribute: .top,
                                                   relatedBy: .equal,
                                                   toItem: titleLabel,
                                                   attribute: .bottom,
                                                   multiplier: 1,
                                                   constant: -2)
            topConstraint.priority = UILayoutPriority.required
            topConstraint.isActive = true

            durationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            let bottomConstraint = NSLayoutConstraint(item: durationLabel,
                                                      attribute: .bottom,
                                                      relatedBy: .equal,
                                                      toItem: contentView,
                                                      attribute: .bottom,
                                                      multiplier: 1,
                                                      constant: 0)
            bottomConstraint.priority = UILayoutPriority(rawValue: 999)
            bottomConstraint.isActive = true

            durationLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 26).isActive = true
            durationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        }
    }
}
