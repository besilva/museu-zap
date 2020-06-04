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

    var sectionView: SectionsHeaderView
    var highlightsCollection: HighlightsCollectionView
    private let pageControL: UIPageControl

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        sectionView = SectionsHeaderView()

        let layout = UICollectionViewFlowLayout()
        // TODO: colocar espacamento igual a Constants.tableViewSpacing To better give the carousel sensation,
        // Mas isso quebra o layout das células, teria que pensar melhor nisso
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
        setUpSectionView()
        setUpPageControl()
    }

    func setupHierarchy() {
        contentView.addSubviews(highlightsCollection, pageControL, sectionView)
    }

    func setupConstraints() {
        setSectionViewConstraints()
        setUpCollectionConstraints()
        setUpPageControlConstraints()
    }

    func render() {
        renderSectionView()
    }

    // MARK: - Set Up Helpers

    func setUpSectionView() {
        sectionView.seeAllButton.addTarget(self, action: #selector(showAllHighlights), for: .touchUpInside)
        // Until there is a view to display, button is hidden
        sectionView.seeAllButton.isHidden = true
    }

    func setUpPageControl() {
        guard let collectionViewModel = highlightsCollection.viewModel else { return }
        pageControL.currentPage = 0
        pageControL.numberOfPages = collectionViewModel.highlightedAudios.count
        pageControL.currentPageIndicatorTintColor = UIColor.Default.power
        pageControL.pageIndicatorTintColor = UIColor.Default.pageControl

    }

    @objc func showAllHighlights(sender: UIButton!) {
        // Code here to list all highlight audios
    }

    func renderSectionView() {
        sectionView.sectionLabel.text = "Top áudios"
    }

    // MARK: - Constraints

    func setSectionViewConstraints() {
        sectionView.setupConstraints { (view) in
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
            // Bottom is at collection Constraints
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        }
    }

    func setUpCollectionConstraints() {
        self.setContentCompressionResistancePriority(.required, for: .vertical)
        self.setContentCompressionResistancePriority(.required, for: .horizontal)

        highlightsCollection.setupConstraints { (view) in
            view.topAnchor.constraint(equalTo: sectionView.bottomAnchor, constant: 0).isActive = true
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
