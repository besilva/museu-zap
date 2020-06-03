//
//  PrivateCategoryCollectionViewModel.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 02/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import DatabaseKit

// View model for a collection view containing only private categories
class PrivateCategoryCollectionViewModel: CategoryCollectionViewModelProtocol {
    
    var categories: [AudioCategory] {
        didSet {
            self.delegate?.reloadCollectionData()
        }
    }
    // I won't use this service because the mother view
    // (my audios) loads the required categories
    var service: AudioCategoryServices
    weak var delegate: CategoryCollectionViewModelDelegate?
    
    init(service: AudioCategoryServices) {
        self.service = service
        categories = []
    }
}
