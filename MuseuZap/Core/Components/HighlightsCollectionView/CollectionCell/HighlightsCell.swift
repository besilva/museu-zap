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
    
//    let iconImageView: UIImageView
//    let titleLabel: UILabel
//    let numberOfAudiosLabel: UILabel
//    var iconWidthConstraint: NSLayoutConstraint?
//    var iconHeightConstraint: NSLayoutConstraint?
    var viewModel: HighlightsCellViewModel? {
        didSet {
            render()
            configure()
        }
    }
     
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    override init(frame: CGRect) {
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
    }
    
    func setupHierarchy() {

    }
    
    func setupConstraints() {

    }
    
    func render() {

    }
    
}
