//
//  HighlightsTableViewCell.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 02/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class HighlightsTableViewCell: UITableViewCell {

    // MARK: - Properties

    var highlightsCollection: HighlightsCollectionView

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.scrollDirection = .horizontal
        highlightsCollection = HighlightsCollectionView(frame: .zero, collectionViewLayout: layout)

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViewModel()
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViewModel() {
         highlightsCollection.viewModel = HighlightsCollectionViewModel()
    }
}

    // MARK: - Set Up

extension HighlightsTableViewCell: ViewCodable {

    func configure() { self.backgroundColor = .red }

    func setupHierarchy() {
        contentView.addSubview(highlightsCollection)
    }

    func setupConstraints() {
        setUpCollectionConstraints()
    }

    func render() { }

    // MARK: - Set Up Helpers


    // MARK: - Constraints

    func setUpCollectionConstraints() {
        self.setContentCompressionResistancePriority(.required, for: .vertical)
        self.setContentCompressionResistancePriority(.required, for: .horizontal)

        highlightsCollection.setupConstraints { (view) in
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 197).isActive = true
        }

    }
}
