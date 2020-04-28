//
//  AudioCellView.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 27/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class AudioCellView: UIView, ViewCodable {
    var contentView: UIView = UIView()

    var titleLabel: UILabel = UILabel()
    var durationLabel: UILabel = UILabel()
    var playIcon: UIImageView = UIImageView()
    var shareIcon: UIImageView = UIImageView()

    var viewModel: AudioCellViewModelProtocol? {
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
        setupTitleLabel()
        setupDurationLabel()
        setupPlayButton()
        setupShareButton()
    }
    
    func setupHierarchy() {
        contentView.addSubviews(titleLabel, durationLabel, playIcon, shareIcon)
        addSubview(contentView)
    }
    
    func setupConstraints() {
        let margins = self.layoutMarginsGuide
        contentView.setupConstraints { (_) in
            contentView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
        
        playIcon.setupConstraints { (_) in
            playIcon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
            playIcon.rightAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: -16).isActive = true
            playIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        }
        
        titleLabel.setupConstraints { (_) in
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
            titleLabel.bottomAnchor.constraint(equalTo: durationLabel.topAnchor, constant: 4).isActive = true
            titleLabel.rightAnchor.constraint(equalTo: shareIcon.leftAnchor, constant: 8).isActive = true
        }
        
        durationLabel.setupConstraints { (_) in
            durationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16).isActive = true
            durationLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 76).isActive = true
        }
        
        shareIcon.setupConstraints { (_) in
            shareIcon.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -9).isActive = true
            shareIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        }
    }
    
    func render() {
        contentView.backgroundColor = UIColor.Default.background
        titleLabel.textColor = UIColor.Default.label
        durationLabel.textColor = UIColor.Default.label
        shareIcon.tintColor = UIColor.systemBlue
    }
    
    func updateView() {
        configure()
    }

    func setupTitleLabel() {
        guard let viewModel = viewModel else { return }
        let audioTitle = viewModel.title

        let titleLabelFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
        titleLabel.font = titleLabelFont
        titleLabel.dynamicFont = titleLabelFont
        
        titleLabel.numberOfLines = 0
        let paragraphStyle = NSMutableParagraphStyle()

        paragraphStyle.lineHeightMultiple = 1.12
        let attributedText = NSMutableAttributedString(string: audioTitle,
                                                       attributes: [NSAttributedString.Key.kern: -0.24,
                                                                    	NSAttributedString.Key.paragraphStyle: paragraphStyle])
        titleLabel.attributedText = attributedText
    }
    
    func setupDurationLabel() {
        guard let viewModel = viewModel else { return }
        let durationString = viewModel.duration.stringFromTimeInterval()
        
        let durationlabelFont = UIFont.systemFont(ofSize: 11, weight: .regular)
        durationLabel.font = durationlabelFont
        durationLabel.dynamicFont = durationlabelFont
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.99

        durationLabel.attributedText = NSMutableAttributedString(string: durationString, attributes: [NSAttributedString.Key.kern: 0.07, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    func setupPlayButton() {
        playIcon.image = UIImage(named: "play.fill")
        playIcon.contentMode = .scaleAspectFit
        
//        Adds behaviour to play audio on tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(changePlayStatus))
        playIcon.isUserInteractionEnabled = true
        playIcon.addGestureRecognizer(tap)
    }
    
    func setupShareButton() {
        shareIcon.image = UIImage(named: "square.and.arrow.up")
        shareIcon.contentMode = .scaleAspectFit
        
//        Adds behaviour to share audio on tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(shareAudio))
        shareIcon.isUserInteractionEnabled = true
        shareIcon.addGestureRecognizer(tap)
    }
    
    @objc func shareAudio() {
        guard let viewModel = viewModel else { return }
        viewModel.share()
    }
    
    @objc func changePlayStatus() {
        guard let viewModel = viewModel else { return }
        viewModel.changePlayStatus()
        playIcon.image = viewModel.playing ? UIImage(named: "pause.fill") : UIImage(named: "play.fill")
    }
}
