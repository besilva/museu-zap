//
//  SearchResultsCell.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 28/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

/// Custom cell to be displayed when a search is performed.
/// Basically equal to AudioCell, with some layout changes.
class SearchResultsCell: AudioCell {

    // MARK: - Set Up

    // So ShareButton does not get called
    override func configure() {
        setUpAudioCellProtocolInfo()
        setupTitleLabel()
        setupDurationLabel()
        setupPlayButton()
        // Commenting this line will turn playButton blue. Somehow tintColor was override to blue?
        playIcon.tintColor = UIColor.Default.power
    }

    // So ShareButton does not get called. Container is also not needed
    override func setupHierarchy() {
        playHitArea.addSubview(playIcon)
        audioDataContentView.addSubviews(titleLabel, durationLabel)
        contentView.addSubviews(audioDataContentView, playHitArea)
    }

    override func setupConstraints() {
        self.setContentCompressionResistancePriority(.required, for: .vertical)
        self.setContentCompressionResistancePriority(.required, for: .horizontal)

        setAudioDataContentViewConstraints()
        setAudioTitleConstraints()
        setAudioDurationConstraints()

        // New Function instead of setPlayIconConstraints()
        setPlayButtonConstraints()
    }

    // Container is not needed
    override func render() {
        //  Sets content view appearance
        contentView.backgroundColor = UIColor.Default.lightBackground

        // Sets text attributes for title label
        titleLabel.textColor = UIColor.Default.label
        titleLabel.font = UIFont.Default.semibold
        titleLabel.dynamicFont = titleLabel.font

        // Sets duration label visual attributes
        durationLabel.textColor = UIColor.Default.lightLabel
        let durationlabelFont = UIFont.Default.regular
        durationLabel.font = durationlabelFont.withSize(12)
        durationLabel.dynamicFont = durationlabelFont
        
        // Adds shadow
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 20
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }

    // MARK: - Set Up Helpers

    // Update View is equal
    // SetupTitleLabel is equal
    // SetupDurationLabel is equal
    // SetupPlayButton is equal
    // Change Status is equal

    // MARK: - Constraints

    // Setup audio data content view constraints
    // AudioDataContentView anchors go to contentView
    override func setAudioDataContentViewConstraints() {

        audioDataContentView.setContentCompressionResistancePriority(.required, for: .vertical)

        audioDataContentView.setupConstraints { (_) in

            audioDataContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
            let bottomConstraint = NSLayoutConstraint(item: audioDataContentView,
                                                      attribute: .bottom,
                                                      relatedBy: .equal,
                                                      toItem: contentView,
                                                      attribute: .bottom,
                                                      multiplier: 1,
                                                      constant: -16)
            bottomConstraint.priority = UILayoutPriority(rawValue: 750)
            bottomConstraint.isActive = true

            let bottomMarginConstraint = NSLayoutConstraint(item: audioDataContentView,
                                                            attribute: .bottom,
                                                            relatedBy: .lessThanOrEqual,
                                                            toItem: contentView,
                                                            attribute: .bottom,
                                                            multiplier: 1,
                                                            constant: -16)
            bottomMarginConstraint.priority = UILayoutPriority(rawValue: 999)
            bottomMarginConstraint.isActive = true
            audioDataContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32).isActive = true
        }
    }

    // Constraint setAudioTitleConstraints is equal
    // Constraint setAudioDurationConstraints is equal

    // New func Setup PlayButton constraints
    func setPlayButtonConstraints() {

        playHitArea.setContentCompressionResistancePriority(.required, for: .horizontal)
        playHitArea.setContentHuggingPriority(.required, for: .horizontal)
        playHitArea.setupConstraints { (_) in
            playHitArea.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
            playHitArea.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32).isActive = true
            playHitArea.trailingAnchor.constraint(equalTo: audioDataContentView.leadingAnchor, constant: -16).isActive = true

            let bottomConstraint = NSLayoutConstraint(item: playHitArea,
                                                      attribute: .bottom,
                                                      relatedBy: .equal,
                                                      toItem: contentView,
                                                      attribute: .bottom,
                                                      multiplier: 1,
                                                      constant: -16)
            bottomConstraint.priority = UILayoutPriority(rawValue: 750)
            bottomConstraint.isActive = true

            createHitAreaConstrains(for: playHitArea)
        }

        playIcon.setContentCompressionResistancePriority(.required, for: .horizontal)
         playIcon.setContentHuggingPriority(.required, for: .horizontal)
         playIcon.setupConstraints { (_) in
             playIcon.centerYAnchor.constraint(equalTo: playHitArea.centerYAnchor).isActive = true
             playIcon.centerXAnchor.constraint(equalTo: playHitArea.centerXAnchor).isActive = true
         }
    }
}
