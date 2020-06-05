//
//  HighlightsCollectionView.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 02/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

protocol HighlightsCollectionViewDelegate: class {
    func updateCurrentPage(toPage: Int)
}

class HighlightsCollectionView: UICollectionView {

    // MARK: - Properties

    var iconManager: CellIconManager
    let cellId = "highlightsCollection"
    var viewModel: HighlightsCollectionViewModelProtocol? {
        didSet {
            viewModel?.delegate = self
            updateView()
        }
    }

    // MARK: - Init
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        iconManager = CellIconManager.shared
        
        super.init(frame: frame, collectionViewLayout: layout)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateView() {
        self.reloadData()
    }
}

    // MARK: - Collection View

extension HighlightsCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    override var numberOfSections: Int { return 1 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else { return 1 }

        return viewModel.highlightedAudios.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let audios = viewModel?.highlightedAudios else {  return UICollectionViewCell() }

        if let cell = self.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? HighlightsCell {
            cell.viewModel = HighlightsCellViewModel(audio: audios[indexPath.row])
            return cell
        }

        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }

    // MARK: - Change Icon

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let highlightsCell = cell as? HighlightsCell else {
            return
        }
        iconManager.updateCellStatus(visible: true, cell: highlightsCell)
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let highlightsCell = cell as? HighlightsCell else {
            return
        }
        iconManager.updateCellStatus(visible: true, cell: highlightsCell)
    }

}

    // MARK: - Scroll

extension HighlightsCollectionView {

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let nextPage = Int(targetContentOffset.pointee.x / self.frame.width)
        viewModel?.updateCurrentPage(toPage: nextPage)
    }
}

    // MARK: - Set Up

extension HighlightsCollectionView: ViewCodable {

    func configure() {
        self.delegate = self
        self.dataSource = self
        self.register(HighlightsCell.self, forCellWithReuseIdentifier: cellId)
        self.isPagingEnabled = true
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }
    
    func setupHierarchy() { }
    
    func setupConstraints() { }
    
    func render() {
        self.backgroundColor = UIColor.Default.background
    }

    // MARK: - Set Up Helpers
}

extension HighlightsCollectionView: HighlightsCollectionViewModelDelegate {

    func reloadCollectionData() {
        self.reloadData()
    }
}
