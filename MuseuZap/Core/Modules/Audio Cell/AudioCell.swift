//
//  AudioCellView.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 27/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class AudioCell: UITableViewCell, ViewCodable {

    var container: UIView = UIView()
    var audioDataContentView: UIView = UIView()
    var titleLabel: UILabel = UILabel()
    var durationLabel: UILabel = UILabel()

    var playHitArea: UIView = UIView()
    var shareHitArea: UIView = UIView()
    var playIcon: UIImageView = UIImageView()
    var shareIcon: UIImageView = UIImageView()
    
    var isPlaying: Bool {
        didSet {
            let pauseIcon = UIImage(named: "pause")
            let playIcon = UIImage(named: "play")
            self.playIcon.image = self.isPlaying ?  pauseIcon : playIcon
        }
    }

    var viewModel: AudioCellViewModelProtocol? {
        didSet {
            updateView()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.isPlaying = false
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        playHitArea.addSubview(playIcon)
        shareHitArea.addSubview(shareIcon)
        audioDataContentView.addSubviews(titleLabel, durationLabel)
        container.addSubviews(audioDataContentView, playHitArea, shareHitArea)
        contentView.addSubview(container)
    }
    
    func setupConstraints() {
        self.setContentCompressionResistancePriority(.required, for: .vertical)
        self.setContentCompressionResistancePriority(.required, for: .horizontal)
        container.setupConstraints { (_) in
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        }

        setAudioDataContentViewConstraints()
        setAudioTitleConstraints()
        setAudioDurationConstraints()
        setPlayIconConstraints()
        setShareIconConstraints()
    }
    
    func render() {
//        Sets content view appearance
        container.layer.cornerRadius = 4
        container.backgroundColor = UIColor.Default.lightBackground

//        Sets text attributes for title label
        titleLabel.textColor = UIColor.Default.label
        titleLabel.font = UIFont.Default.semibold
        titleLabel.dynamicFont = titleLabel.font

//      Sets duration label visual attributes
        durationLabel.textColor = UIColor.Default.lightLabel
        let durationlabelFont = UIFont.Default.regular
        durationLabel.font = durationlabelFont.withSize(12)
        durationLabel.dynamicFont = durationlabelFont
        
//        Set icons colors
        shareIcon.tintColor = UIColor.Default.power
        playIcon.tintColor = UIColor.Default.power
        
//        Adds shadow
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 20
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    func updateView() {
        configure()
    }
    
    func setupAudioDataContentView() {
        audioDataContentView.backgroundColor = UIColor.Default.lightBackground
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
    }
    
    func setupDurationLabel() {
//        Loads and formats content from viewModel
        guard let viewModel = viewModel else { return }
        let durationString = viewModel.duration.stringFromTimeInterval()
        
//        Sets text style attributes
        let attributedText = NSMutableAttributedString(string: durationString,
                                                       attributes: [NSAttributedString.Key.kern: 0.07])
        durationLabel.attributedText = attributedText
        durationLabel.textAlignment = .left
    }

    func setupPlayButton() {
        playIcon.image = UIImage(named: "play.fill")
        playIcon.contentMode = .scaleAspectFit
        
//        Adds behaviour to play audio on tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(changePlayStatus))
        playHitArea.isUserInteractionEnabled = true
        playHitArea.addGestureRecognizer(tap)
    }
    
    func setupShareButton() {
        shareIcon.image = UIImage(named: "share")
        shareIcon.contentMode = .scaleAspectFit
        
//        Adds behaviour to share audio on tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(shareAudio))
        shareHitArea.isUserInteractionEnabled = true
        shareHitArea.addGestureRecognizer(tap)
    }
    
    @objc func shareAudio() {
        guard let viewModel = viewModel else { return }
        viewModel.share()
    }
    
    @objc func changePlayStatus() {
        guard let viewModel = viewModel else { return }
        viewModel.changePlayStatus(cell: self)
    }
}

// Constraint setting methods
extension AudioCell {
//      Setup audio data content view constraints
    func setAudioDataContentViewConstraints() {
        
        audioDataContentView.setContentCompressionResistancePriority(.required, for: .vertical)

        audioDataContentView.setupConstraints { (_) in

            audioDataContentView.topAnchor.constraint(equalTo: container.topAnchor, constant: 16).isActive = true
            let bottomConstraint = NSLayoutConstraint(item: audioDataContentView,
                                                      attribute: .bottom,
                                                      relatedBy: .equal,
                                                      toItem: container,
                                                      attribute: .bottom,
                                                      multiplier: 1,
                                                      constant: -16)
            bottomConstraint.priority = UILayoutPriority(rawValue: 750)
            bottomConstraint.isActive = true

            let bottomMarginConstraint = NSLayoutConstraint(item: audioDataContentView,
                                                            attribute: .bottom,
                                                            relatedBy: .lessThanOrEqual,
                                                            toItem: container,
                                                            attribute: .bottom,
                                                            multiplier: 1,
                                                            constant: -16)
            bottomMarginConstraint.priority = UILayoutPriority(rawValue: 999)
            bottomMarginConstraint.isActive = true
            audioDataContentView.trailingAnchor.constraint(equalTo: shareHitArea.leadingAnchor, constant: -8).isActive = true
        }
    }

//        Setup audio title constraints
    func setAudioTitleConstraints() {
        titleLabel.sizeToFit()
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.setupConstraints { (_) in
            titleLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
            titleLabel.topAnchor.constraint(equalTo: audioDataContentView.topAnchor).isActive = true
            titleLabel.leadingAnchor.constraint(equalTo: audioDataContentView.leadingAnchor).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo: audioDataContentView.trailingAnchor).isActive = true
        }
    }
    
//        Setup audio duration constraints
    func setAudioDurationConstraints() {
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
            
            durationLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 26).isActive = true
            durationLabel.leadingAnchor.constraint(equalTo: audioDataContentView.leadingAnchor).isActive = true
        }
    }
    
//        Setup play icon constraints, inside hitArea
    func setPlayIconConstraints() {

        playHitArea.setContentCompressionResistancePriority(.required, for: .horizontal)
        playHitArea.setContentHuggingPriority(.required, for: .horizontal)
        playHitArea.setupConstraints { (_) in
            playHitArea.topAnchor.constraint(equalTo: container.topAnchor, constant: 16).isActive = true
            playHitArea.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16).isActive = true
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

//        Setup share icon constraints, inside hitArea
    func setShareIconConstraints() {

        shareHitArea.setContentCompressionResistancePriority(.required, for: .horizontal)
        shareHitArea.setContentHuggingPriority(.required, for: .horizontal)
        shareHitArea.setupConstraints { (_) in
            // Leading anchor was already set in audioDataContentView
            shareHitArea.topAnchor.constraint(equalTo: container.topAnchor, constant: 16).isActive = true
            shareHitArea.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8).isActive = true

            createHitAreaConstrains(for: shareHitArea)
        }

        shareIcon.setContentCompressionResistancePriority(.required, for: .horizontal)
        shareIcon.setContentHuggingPriority(.required, for: .horizontal)
        shareIcon.setupConstraints { (_) in
            shareIcon.centerYAnchor.constraint(equalTo: shareHitArea.centerYAnchor).isActive = true
            shareIcon.centerXAnchor.constraint(equalTo: shareHitArea.centerXAnchor).isActive = true
        }
    }
}

extension AudioCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        self.isPlaying = false
    }
}

    // MARK: - Constrains Helper

extension AudioCell {

    /// Creates minimum hitArea constrains as fixed constrains
    func createHitAreaConstrains(for view: UIView) {
        let width = NSLayoutConstraint(item: view,
                                       attribute: .width,
                                       relatedBy: .equal,
                                       toItem: nil,
                                       attribute: .width,
                                       multiplier: 1,
                                       constant: 44)
        width.isActive = true

        let heigh = NSLayoutConstraint(item: view,
                                       attribute: .height,
                                       relatedBy: .equal,
                                       toItem: nil,
                                       attribute: .height,
                                       multiplier: 1,
                                       constant: 44)
        heigh.isActive = true
    }
}
