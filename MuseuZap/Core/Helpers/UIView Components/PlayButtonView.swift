//
//  PlayButtonView.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 28/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

/// Creates a View with playIcon in the middle
class PlayButtonView: UIView {
    public var icon: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Set icons colors
        icon.tintColor = UIColor.Default.power
        icon.image = UIImage.Default.playIcon
        icon.contentMode = .scaleAspectFit
        self.addSubview(icon)

        self.translatesAutoresizingMaskIntoConstraints = false
        setUpHitAreaConstraints()
        setUpIconConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Creates minimum hitArea constraints as fixed constrains
    func setUpHitAreaConstraints() {
        let width = NSLayoutConstraint(item: self,
                                       attribute: .width,
                                       relatedBy: .equal,
                                       toItem: nil,
                                       attribute: .width,
                                       multiplier: 1,
                                       constant: 44)
        width.isActive = true

        let height = NSLayoutConstraint(item: self,
                                       attribute: .height,
                                       relatedBy: .equal,
                                       toItem: nil,
                                       attribute: .height,
                                       multiplier: 1,
                                       constant: 44)
        height.isActive = true
    }

    func setUpIconConstraints() {
        icon.setContentCompressionResistancePriority(.required, for: .horizontal)
        icon.setContentHuggingPriority(.required, for: .horizontal)
        icon.setupConstraints { (_) in
            icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            icon.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        }
    }
}
