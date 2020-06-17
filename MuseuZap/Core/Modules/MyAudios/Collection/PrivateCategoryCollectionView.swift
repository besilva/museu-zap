//
//  PrivateCategory CollectionView.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 03/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import DatabaseKit
import UIKit

class PrivateCategoryCollectionView: CategoryCollectionView {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Loads categories from view model
        guard let categories = viewModel?.categories else {  return UICollectionViewCell() }
        if let cell = self.dequeueReusableCell(withReuseIdentifier: "category", for: indexPath) as? PrivateCategoryCell {
            // User private category cell and view model classes
            cell.viewModel = PrivateCategoryCellViewModel(category: categories[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    override func configure() {
        self.delegate = self
        self.dataSource = self
        self.register(PrivateCategoryCell.self, forCellWithReuseIdentifier: "category")
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Adjusts cell width to fill whole collection view frame
        let cellWidth = Int(self.frame.width / 2) - 8
        return CGSize(width: cellWidth, height: 162)
    }
}
