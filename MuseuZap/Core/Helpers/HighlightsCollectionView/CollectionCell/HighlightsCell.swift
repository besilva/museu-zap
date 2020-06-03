//
//  HighlightsCell.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 02/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
//import DatabaseKit

class HighlightsCell: UICollectionViewCell {

    // MARK: - Properties

    var playButton: PlayButtonView
    
    var viewModel: HighlightsCellViewModel? {
        didSet {
            render()
            configure()
        }
    }

    // MARK: - Init
     
    init() {
        playButton = PlayButtonView()

        super.init(frame: .zero)

        setupView()
    }
    
    override init(frame: CGRect) {
        playButton = PlayButtonView()

        super.init(frame: frame)

        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

    // MARK: - Set Up

extension HighlightsCell: ViewCodable {

    func configure() {
        self.backgroundColor = .purple
        setUpPlayButton()
    }
    
    func setupHierarchy() {
        self.addSubviews(playButton)
    }
    
    func setupConstraints() {
         setUpPlayButtonConstraints()
    }
    
    func render() { }

    // MARK: - Set Up Helpers

    func setUpPlayButton() {
        playButton.icon.image = UIImage.Default.playIconHighlights
        // Adds behaviour to play audio on tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(changePlayStatus))
        playButton.isUserInteractionEnabled = true
        playButton.addGestureRecognizer(tap)
    }

    func setUpPlayButtonConstraints() {
        playButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        playButton.setContentHuggingPriority(.required, for: .horizontal)
        playButton.setupConstraints { (view) in
            view.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        }
    }

    // MARK: - changePlayStatus

    @objc func changePlayStatus() {
        guard let viewModel = viewModel else { return }
        viewModel.changePlayStatus()
    }

}
