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

    var audioImage: UIImageView
    var playButton: PlayButtonView
    var audioDataView: AudioDataView
    
    var viewModel: HighlightsCellViewModel? {
        didSet {
            render()
            configure()
        }
    }

    // MARK: - Init
     
    init() {
        audioImage = UIImageView()
        playButton = PlayButtonView()
        audioDataView = AudioDataView()

        super.init(frame: .zero)

        setupView()
    }
    
    override init(frame: CGRect) {
        audioImage = UIImageView()
        playButton = PlayButtonView()
        audioDataView = AudioDataView()

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
        setUpAudioImage()
        setUpPlayButton()
        setUpAudioDataView()
    }
    
    func setupHierarchy() {
        // Playbutton should be added directly to HighlightsCell so that tap works
        self.addSubviews(audioImage, playButton, audioDataView)
    }
    
    func setupConstraints() {
        setAudioImageConstraints()
        setPlayButtonConstraints()
        setAudioDataViewConstraints()
    }
    
    func render() {
        self.backgroundColor = UIColor.Default.background
    }

    // MARK: - Set Up Helpers

    func setUpAudioImage() {
        guard let viewModel = viewModel else { return }
        // TODO: resolver isso
        audioImage.contentMode = .scaleAspectFill
        audioImage.image = UIImage.Highlights.uma?.withRoundedCorners(radius: 10)
    }

    func setUpPlayButton() {
        playButton.icon.image = UIImage.Default.playIconHighlights
        playButton.icon.tintColor = UIColor.white
        // Adds behaviour to play audio on tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(changePlayStatus))
        playButton.isUserInteractionEnabled = true
        playButton.addGestureRecognizer(tap)
    }

    func setUpAudioDataView() {

    }

    // MARK: - Constraints

    /// ImageView occupies the whole CollectionViewCell, with 16 spacing to HeaderView (table view cell)
    func setAudioImageConstraints() {
        audioImage.setContentCompressionResistancePriority(.required, for: .vertical)
        audioImage.setContentCompressionResistancePriority(.required, for: .horizontal)
        audioImage.setupConstraints { (view) in
          view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
          view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
          view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
          view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        }
    }

    /// PlayButton is at the center from imageView
    func setPlayButtonConstraints() {
        playButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        playButton.setContentHuggingPriority(.required, for: .horizontal)
        playButton.setupConstraints { (view) in
            view.centerYAnchor.constraint(equalTo: audioImage.centerYAnchor).isActive = true
            view.centerXAnchor.constraint(equalTo: audioImage.centerXAnchor).isActive = true
        }
    }

    func setAudioDataViewConstraints() {
        audioDataView.setContentCompressionResistancePriority(.required, for: .horizontal)
        audioDataView.setContentHuggingPriority(.required, for: .horizontal)
        audioDataView.setupConstraints { (view) in
            // Do not pin audioData top constraint
            view.bottomAnchor.constraint(equalTo: audioImage.bottomAnchor, constant: -20).isActive = true
            view.leadingAnchor.constraint(equalTo: audioImage.leadingAnchor, constant: 20).isActive = true
            view.trailingAnchor.constraint(equalTo: audioImage.trailingAnchor, constant: -20).isActive = true
        }
    }

    // MARK: - changePlayStatus

    @objc func changePlayStatus() {
        guard let viewModel = viewModel else { return }
        viewModel.changePlayStatus()
    }

}
