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
    
    var audioDataContentView: UIView = UIView()
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
        audioDataContentView.addSubviews(titleLabel, durationLabel)
        contentView.addSubviews(audioDataContentView, playIcon, shareIcon)
        addSubview(contentView)
    }
    
    func setupConstraints() {
        self.setContentCompressionResistancePriority(.required, for: .vertical)
        self.setContentCompressionResistancePriority(.required, for: .horizontal)
        contentView.setupConstraints { (_) in
            contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }

//      Setup audio data content view constraints
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
            audioDataContentView.trailingAnchor.constraint(equalTo: shareIcon.leadingAnchor, constant: -24).isActive = true
        }
        
//        Setup audio title constraints
        titleLabel.sizeToFit()
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.setupConstraints { (_) in
            titleLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
            titleLabel.topAnchor.constraint(equalTo: audioDataContentView.topAnchor).isActive = true
            titleLabel.leadingAnchor.constraint(equalTo: audioDataContentView.leadingAnchor).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo: audioDataContentView.trailingAnchor).isActive = true
        }
        
//        Setup audio duration constraints
        durationLabel.setupConstraints { (_) in
            let topConstraint = NSLayoutConstraint(item: durationLabel,
                                                      attribute: .top,
                                                      relatedBy: .equal,
                                                      toItem: titleLabel,
                                                      attribute: .bottom,
                                                      multiplier: 1,
                                                      constant: 4)
            topConstraint.priority = UILayoutPriority.required
            topConstraint.isActive = true
            
            durationLabel.bottomAnchor.constraint(equalTo: audioDataContentView.bottomAnchor).isActive = true
            let bottomConstraint = NSLayoutConstraint(item: durationLabel,
                                                      attribute: .bottom,
                                                      relatedBy: .equal,
                                                      toItem: audioDataContentView,
                                                      attribute: .bottom,
                                                      multiplier: 1,
                                                      constant: 0)
            bottomConstraint.priority = UILayoutPriority(rawValue: 999)
            bottomConstraint.isActive = true
            
            durationLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 13).isActive = true
            durationLabel.leadingAnchor.constraint(equalTo: audioDataContentView.leadingAnchor).isActive = true
        }

//        Setup play icon constraints
        playIcon.setContentCompressionResistancePriority(.required, for: .horizontal)
        playIcon.setContentHuggingPriority(.required, for: .horizontal)
        playIcon.setupConstraints { (_) in
            playIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
            playIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24).isActive = true
            playIcon.trailingAnchor.constraint(equalTo: audioDataContentView.leadingAnchor, constant: -16).isActive = true
        }

//        Setup share icon constraints
        shareIcon.setContentCompressionResistancePriority(.required, for: .horizontal)
        shareIcon.setContentHuggingPriority(.required, for: .horizontal)
        shareIcon.setupConstraints { (_) in
            shareIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
            shareIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        }
    }
    
    func render() {
        contentView.backgroundColor = UIColor.Default.background

        titleLabel.textColor = UIColor.Default.label
        titleLabel.font = UIFont.Default.semibold
        titleLabel.dynamicFont = titleLabel.font

        durationLabel.textColor = UIColor.Default.label
        durationLabel.font = UIFont.Default.regular?.withSize(12)

        shareIcon.tintColor = UIColor.Default.power
        playIcon.tintColor = UIColor.Default.power
        
        // Debug colors
        contentView.backgroundColor = .systemRed
        audioDataContentView.backgroundColor = .systemBlue
        titleLabel.backgroundColor = .systemGray
        durationLabel.backgroundColor = .systemTeal
        shareIcon.backgroundColor = .white
        playIcon.backgroundColor = .white
    }
    
    func updateView() {
        configure()
    }
    
    func setupAudioDataContentView() {
        audioDataContentView.backgroundColor = UIColor.Default.background
    }

    func setupTitleLabel() {
        guard let viewModel = viewModel else { return }
        let audioTitle = viewModel.title
    
        titleLabel.numberOfLines = 0
        let paragraphStyle = NSMutableParagraphStyle()

        paragraphStyle.lineHeightMultiple = 0.9
        let attributedText = NSMutableAttributedString(string: audioTitle,
                                                       attributes: [NSAttributedString.Key.kern: 0.34,
                                                                    	NSAttributedString.Key.paragraphStyle: paragraphStyle])
        titleLabel.attributedText = attributedText
        titleLabel.textAlignment = .left
        titleLabel.backgroundColor = .black
    }
    
    func setupDurationLabel() {
        guard let viewModel = viewModel else { return }
        let durationString = viewModel.duration.stringFromTimeInterval()
        
        let durationlabelFont = UIFont.systemFont(ofSize: 11, weight: .regular)
        durationLabel.font = durationlabelFont
        durationLabel.dynamicFont = durationlabelFont
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.72
        
        let attributedText = NSMutableAttributedString(string: durationString,
                                                       	attributes: [NSAttributedString.Key.kern: 0.07,
                                                                        NSAttributedString.Key.paragraphStyle: paragraphStyle])
        durationLabel.attributedText = attributedText
        durationLabel.textAlignment = .left
        durationLabel.backgroundColor = .black
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
