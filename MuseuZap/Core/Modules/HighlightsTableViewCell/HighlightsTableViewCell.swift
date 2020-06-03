//
//  HighlightsTableViewCell.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 02/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

protocol HighlightsTableViewCellDelegate: class {
    func updatePageControlToPage(toPage: Int)
}

class HighlightsTableViewCell: UITableViewCell {

    // MARK: - Properties

    var highlightsCollection: HighlightsCollectionView
    private let pageControL: UIPageControl

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal

        highlightsCollection = HighlightsCollectionView(frame: .zero, collectionViewLayout: layout)

        pageControL = UIPageControl()

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViewModel()
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViewModel() {
        let viewModel = HighlightsCollectionViewModel()
        viewModel.tableViewDelegate = self
        highlightsCollection.viewModel = viewModel
    }
}

extension HighlightsTableViewCell: HighlightsTableViewCellDelegate {

    func updatePageControlToPage(toPage page: Int) {
        pageControL.currentPage = page
    }
    
}

    // MARK: - Set Up

extension HighlightsTableViewCell: ViewCodable {

    func configure() {
        setUpPageControl()
    }

    func setupHierarchy() {
        contentView.addSubviews(highlightsCollection, pageControL)
    }

    func setupConstraints() {
        setUpCollectionConstraints()
        setUpPageControlConstraints()
    }

    func render() { }

    // MARK: - Set Up Helpers

    func setUpPageControl() {
        guard let collectionViewModel = highlightsCollection.viewModel else { return }
        pageControL.currentPage = 0
        pageControL.numberOfPages = collectionViewModel.highlightedAudios.count
        pageControL.currentPageIndicatorTintColor = UIColor.Default.power
        pageControL.pageIndicatorTintColor = UIColor.Default.lightLabel // TODO: verificar cor
    }

    // MARK: - Constraints

    func setUpCollectionConstraints() {
        self.setContentCompressionResistancePriority(.required, for: .vertical)
        self.setContentCompressionResistancePriority(.required, for: .horizontal)

        highlightsCollection.setupConstraints { (view) in
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
            view.bottomAnchor.constraint(equalTo: pageControL.topAnchor, constant: 0).isActive = true
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 197).isActive = true
        }

    }

    func setUpPageControlConstraints() {
        pageControL.setupConstraints { (view) in
            // Top is in highlightsCollection
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        }
    }
}
