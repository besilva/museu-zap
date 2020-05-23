//
//  CategoryCollectionView.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 20/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import DatabaseKit

class CategoryCollectionView: UICollectionView {
    
    var viewModel: CategoryCollectionViewModel? {
        didSet {
            viewModel?.delegate = self
            updateView()
        }
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.register(CategoryCell.self, forCellWithReuseIdentifier: "category")
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = UIColor.Default.background
    }
    
    convenience init(categories: [AudioCategory]) {
        self.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView() {
        self.reloadData()
    }
}

extension CategoryCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    override var numberOfSections: Int { return 1 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.categories.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let categories = viewModel?.categories else {  return UICollectionViewCell() }
        if let cell = self.dequeueReusableCell(withReuseIdentifier: "category", for: indexPath) as? CategoryCell {
            cell.viewModel = CategoryCellViewModel(category: categories[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 162, height: 162)
    }

}

extension CategoryCollectionView: CategoryCollectionViewModelDelegate {
    func reloadCollectionData() {
        self.reloadData()
    }
}
